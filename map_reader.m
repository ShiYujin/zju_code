function [skel_node, edge, face, map, skel_num, edge_num, face_num, map_num] = map_reader(file_name)
%
%  If no file input, try to get one from the user.
%
  if ( nargin < 1 )
    file_name = input ( 'Enter the name of the ASCII cg file.' );
    if ( isempty ( file_name ) )
      return
    end
  end
  
  [skel_num, edge_num, face_num, map_num] = get_size(file_name);

  [skel_node, edge, face, map] = read_file(file_name, skel_num, edge_num, face_num, map_num);
  
end

%% get the size of cg file
function [vl,el,fl,mapl] = get_size(file_name)
%
%  If no file input, try to get one from the user.
%
  if ( nargin < 1 )
    file_name = input ( 'Enter the name of the ASCII cg file.' );
    if ( isempty ( file_name ) )
      return
    end
  end
%
%  Open the file.
%
  file_unit = fopen ( file_name, 'r' );

  if ( file_unit < 0 )
    fprintf ( 1, 'get_size - Fatal error!\n' );
    fprintf ( 1, '  Could not open the file "%s".\n', file_name );
    error ( 'get_size - Fatal error!' );
  end
%
%  Read a line of text from the file.
%
  vl = 0;
  el = 0;
  fl = 0;
  mapl = 0;
  while(1)
      text = fgetl(file_unit);
      
      if(text == -1)
          break;
      end
      
      if(text(1:2) == '# ')
          continue;
      end
      
      if(text(1:2) == 'v ')
          vl = vl + 1;
      elseif(text(1) == 'e')
          el = el + 1;
      elseif(text(1) == 'f')
          fl = fl + 1;
      elseif(text(1:4) == '#map')
          mapl = mapl + 1;
      end
  end
  fclose(file_unit);
end

%% read cg file
function [skel_node, edge, face, map] = read_file(file_name,vl,el,fl,mapl)
%
%  If no file input, try to get one from the user.
%
  if ( nargin < 1 )
    input_file_name = input ( 'Enter the name of the ASCII OBJ file.' );
    if ( isempty ( file_name ) )
      return
    end
  end
  
  skel_node = zeros(3, vl);
  edge = zeros(2, el);
  face = zeros(3, fl);
  map = zeros(2, mapl);
  
  skel_cur = 1;
  edge_cur = 1;
  face_cur = 1;
  map_cur = 1;
  
  file_unit = fopen(file_name, 'r');
  
  if ( file_unit < 0 )
    fprintf ( 1, 'read_cg_file - Fatal error!\n' );
    fprintf ( 1, '  Could not open the file "%s".\n', input_file_name );
    error ( 'read_cg_file - Fatal error!' );
  end
  
  while(1)
      test = fgetl(file_unit);
      
      if(test == -1)
          break;
      end
      
      if(test(1:2) == 'v ')
          % vertex
          if(skel_cur <= vl)
              space = strfind(test, ' ');
              skel_node(1,skel_cur) = str2double(test(space(1):space(2)));
              skel_node(2,skel_cur) = str2double(test(space(2):space(3)));
              skel_node(3,skel_cur) = str2double(test(space(3):end));
          else
              fprintf(1, 'skeleton node overflow!\n');
          end
          skel_cur = skel_cur + 1;
          
      elseif(test(1) == 'e')
          % edge
          if(edge_cur <= el)
              space = strfind(test, ' ');
              tem = str2num(test(space(1):end));
              edge(:,edge_cur) = tem';
          else
              fprintf(1, 'edge number overflow!\n');
          end
          edge_cur = edge_cur + 1;
          
      elseif(test(1) == 'f')
          % face
          if(face_cur <= fl)
              space = strfind(test, ' ');
              slash = strfind(test, '//');
              face(1,face_cur) = str2num(test(space(1):slash(1)-1));
              face(2,face_cur) = str2num(test(space(2):slash(2)-1));
              face(3,face_cur) = str2num(test(space(3):slash(3)-1));
          else
              fprintf(1, 'face number overflow!\n');
          end
          face_cur = face_cur + 1;
          
      elseif(test(1:4) == '#map')
          % map
          if(map_cur <= mapl)
              space = strfind(test, ' ');
              tem = str2num(test(space(1):end));
              map(:,map_cur) = tem';
          else
              fprintf(1, 'map number overflow!\n');
          end
          map_cur = map_cur + 1;    
          
      else
          % # / vn
          continue;
      end
  end
end