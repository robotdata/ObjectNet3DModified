function Display_White_CAD
uiwait(msgbox('Enter the root directory','RootDirectory'));
root = uigetdir;
% save the images or not
is_save = 1;
if is_save
    uiwait(msgbox('Enter the output directory','OutputDirectory'));
    out_dir = uigetdir;
    if exist(out_dir, 'dir') == 0
        mkdir(out_dir);
    end
end

% load CAD models
fprintf('loading CAD models\n');
object = load(fullfile(root, 'CAD/cads.mat'));
fprintf('CAD models loaded\n');
cads = object.cads;
class_names = object.class_names;

cmap = colormap(hsv(9));

% list annotation files
ann_dir = fullfile(root, 'Annotations');
filename = fullfile(ann_dir, '*.mat');
files = dir(filename);

if is_save
    index = 1:numel(files);
else
    % randomly show annotations
    index = randperm(numel(files));
end

% for each annotation
for k = index
    name = files(k).name;
    folder = files(k).folder;
    mat_file = load(sprintf('%s\\%s',folder,name));
    file_name = mat_file.record.filename;
    id = name(1:end-4);
    fprintf('%d: %s\n', k, id);

    % read image
    filename = fullfile(root, sprintf('Images/%s', file_name));
    I = imread(filename);
    new_img = zeros(size(I,1),size(I,2))
    hf = figure(1);
    imshow(new_img);
    hold on;

    % load annotation
    filename = fullfile(ann_dir, name);
    object = load(filename);
    objects = object.record.objects;
    num = numel(objects);

    % for each object
    for j = 1:num
        % draw bounding box
        bbox = objects(j).bbox;
        bbox_draw = [bbox(1) bbox(2) bbox(3)-bbox(1) bbox(4)-bbox(2)];
        rectangle('Position', bbox_draw, 'EdgeColor', 'g', 'LineWidth', 2);
        cls = objects(j).class;
        text(bbox(1), bbox(2), cls, 'BackgroundColor', [.7 .9 .7]);

        if isempty(objects(j).viewpoint) == 0
            cls = objects(j).class;
            cls_index = find(strcmp(cls, class_names) == 1);
            cad_index = objects(j).cad_index;

            % viewpoint information
            viewpoint = objects(j).viewpoint;
            % azimuth
            if isfield(viewpoint, 'azimuth') == 0 || isempty(viewpoint.azimuth) == 1
                a = viewpoint.azimuth_coarse;
            else
                a = viewpoint.azimuth;
            end
            % elevation
            if isfield(viewpoint, 'elevation') == 0 || isempty(viewpoint.elevation) == 1
                e = viewpoint.elevation_coarse;
            else
                e = viewpoint.elevation;
            end
            
            % focal length
            f = viewpoint.focal;
            % in-plane rotation
            theta = viewpoint.theta;
            % distance
            d = viewpoint.distance;
            % principal point
            px = viewpoint.px;
            py = viewpoint.py;
            % viewport
            viewport = viewpoint.viewport;

            if isempty(theta), theta = 0; end
            if isempty(d), d = 5; end
            if isempty(f), f = 1; end
            if isempty(viewport), viewport = 2000; end
            if isempty(px), px = (bbox(3) + bbox(1))/2; end
            if isempty(py), py = (bbox(4) + bbox(2))/2; end
            principal = [px py];

            % overlap the CAD model
            vertex = cads{cls_index}(cad_index).vertices;
            face = cads{cls_index}(cad_index).faces;
            if isfield(cads{cls_index},'face4') == 1
                f4 = cads{cls_index}(cad_index).face4;
                disp(id);
            end
            % projection function
            x2d = project_3d_msid(vertex, a, e, d, f, theta, principal, viewport);
            index_color = 1 + floor((j-1) * size(cmap,1) / num);
            p1 = patch('vertices', x2d, 'faces', face, ...
                'FaceColor', 'white', 'FaceAlpha', 0.2, 'EdgeColor', 'None');
            if isfield(cads{cls_index},'face4') == 1
               a =  sprintf('Class index for %d',cls_index);
                disp(a);
                 p2 = patch('vertices', x2d, 'faces', f4, ...
                'FaceColor', 'white', 'FaceAlpha', 0.2, 'EdgeColor', 'None');
            end
        end
    end
    hold off;

    if is_save
        filename = fullfile(out_dir, [id '.png']);
        disp(filename);
        hgexport(hf, filename, hgexport('factorystyle'), 'Format', 'png');
    else
        pause;
    end
end