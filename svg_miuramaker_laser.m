filename = 'miura.svg';
column_width = 100;
num_columns = 10;
row_height = 100;
num_rows = 7;
angle = 30;
vertex_gap = 5; %At an intersection this is the radius.
lasergapy = 5;


svg_width = column_width*num_columns;
extra_height = ceil(tan(angle/180*pi)*column_width);
svg_height = row_height*num_rows+extra_height;

vertexgapx = ceil(vertex_gap*cos(angle/180*pi));
vertexgapy = ceil(vertex_gap*sin(angle/180*pi));

fid = fopen(filename,'w');
fprintf(fid,'<svg width="%d" height="%d" viewBox="0 0 %d %d" xmlns="http://www.w3.org/2000/svg" version="1.1">\n',svg_width,svg_height,svg_width,svg_height);
fprintf(fid,'<g transform="translate(0,%d)">\n',svg_height);
fprintf(fid,'<g transform="scale(1,-1)">\n');

fprintf(fid,'<rect x="0" y="0" width="%d" height="%d" style="fill:none;stroke-width:1;stroke:rgb(0,0,0)" />\n',svg_width,svg_height);

mbv=[column_width,vertex_gap+extra_height,column_width,row_height-vertex_gap+extra_height,255,0]; %middle bottom vertical
mtv=[column_width,row_height+vertex_gap+extra_height,column_width,2*row_height-vertex_gap+extra_height,0,255]; %middle top vertical
rbv=[2*column_width,vertex_gap,2*column_width,row_height-vertex_gap,0,255]; %right bottom vertical
rtv=[2*column_width,row_height+vertex_gap,2*column_width,2*row_height-vertex_gap,255,0]; %right top vertical

bld=[vertexgapx,vertexgapy,column_width-vertexgapx,extra_height-vertexgapy,255,0]; %bottom left diagonal
tld=[vertexgapx,row_height+vertexgapy,column_width-vertexgapx,row_height+extra_height-vertexgapy,0,255]; %top left diagonal
brd=[column_width+vertexgapx,extra_height-vertexgapy,2*column_width-vertexgapx,vertexgapy,255,0]; %bottom right diagonal
trd=[column_width+vertexgapx,row_height+extra_height-vertexgapy,2*column_width-vertexgapx,row_height+vertex_gap-vertexgapy,0,255]; %top right diagonal


for m=1:num_columns,
  for n=1:num_rows+1,
    if mod(m,2)==1, %Odd columns
      if m>1, %The first column is the left edge, so it's skipped here for the verticals but below it draws the diagonals
        if n<num_rows+1, %Top bits are done separately
          if mod(n,2)==0, %Color change mountain/valley
            x1=(m-1)*column_width; y1=(n-1)*row_height+vertex_gap; x2=(m-1)*column_width; y2=n*row_height-vertex_gap;
            fprintf(fid,'<path d="M %d %d L %d %d" stroke="rgb(255,0,0)" stroke-width="1" />\n',x1,y1,x2,y2);
            x1=(m-1)*column_width+vertexgapx; y1=(n-1)*row_height+vertexgapy; x2=m*column_width-vertexgapx; y2=(n-1)*row_height+extra_height-vertexgapy;
            fprintf(fid,'<path d="M %d %d L %d %d" stroke="rgb(0,0,255)" stroke-width="1" />\n',x1,y1,x2,y2);
          else
            x1=(m-1)*column_width; y1=(n-1)*row_height+vertex_gap; x2=(m-1)*column_width; y2=n*row_height-vertex_gap;
            fprintf(fid,'<path d="M %d %d L %d %d" stroke="rgb(0,0,255)" stroke-width="1" />\n',x1,y1,x2,y2);
            x1=(m-1)*column_width+vertexgapx; y1=(n-1)*row_height+vertexgapy; x2=m*column_width-vertexgapx; y2=(n-1)*row_height+extra_height-vertexgapy;
            fprintf(fid,'<path d="M %d %d L %d %d" stroke="rgb(255,0,0)" stroke-width="1" />\n',x1,y1,x2,y2);
          endif
        else %Top little bits
          if mod(n,2)==0, %Color change mountain/valley
            x1=(m-1)*column_width; y1=(n-1)*row_height+vertex_gap; x2=(m-1)*column_width; y2=(n-1)*row_height+extra_height-vertex_gap;
            fprintf(fid,'<path d="M %d %d L %d %d" stroke="rgb(255,0,0)" stroke-width="1" />\n',x1,y1,x2,y2);
            x1=(m-1)*column_width+vertexgapx; y1=(n-1)*row_height+vertexgapy; x2=m*column_width-vertexgapx; y2=(n-1)*row_height+extra_height-vertexgapy;
            fprintf(fid,'<path d="M %d %d L %d %d" stroke="rgb(0,0,255)" stroke-width="1" />\n',x1,y1,x2,y2);
          else
            x1=(m-1)*column_width; y1=(n-1)*row_height+vertex_gap; x2=(m-1)*column_width; y2=(n-1)*row_height+extra_height-vertex_gap;
            fprintf(fid,'<path d="M %d %d L %d %d" stroke="rgb(0,0,255)" stroke-width="1" />\n',x1,y1,x2,y2);
            x1=(m-1)*column_width+vertexgapx; y1=(n-1)*row_height+vertexgapy; x2=m*column_width-vertexgapx; y2=(n-1)*row_height+extra_height-vertexgapy;
            fprintf(fid,'<path d="M %d %d L %d %d" stroke="rgb(255,0,0)" stroke-width="1" />\n',x1,y1,x2,y2);
          endif
        endif
      else %First column diagonals
        if mod(n,2)==0, %Color change mountain/valley
          x1=(m-1)*column_width+vertexgapx; y1=(n-1)*row_height+vertexgapy; x2=m*column_width-vertexgapx; y2=(n-1)*row_height+extra_height-vertexgapy;
          fprintf(fid,'<path d="M %d %d L %d %d" stroke="rgb(0,0,255)" stroke-width="1" />\n',x1,y1,x2,y2);
        else
          x1=(m-1)*column_width+vertexgapx; y1=(n-1)*row_height+vertexgapy; x2=m*column_width-vertexgapx; y2=(n-1)*row_height+extra_height-vertexgapy;
          fprintf(fid,'<path d="M %d %d L %d %d" stroke="rgb(255,0,0)" stroke-width="1" />\n',x1,y1,x2,y2);
        endif
      endif
    else %Even columns
      if mod(n,2)==0, %Color change mountain/valley
        x1=(m-1)*column_width; y1=(n-1)*row_height+vertex_gap+extra_height; x2=(m-1)*column_width; y2=n*row_height-vertex_gap+extra_height;
        fprintf(fid,'<path d="M %d %d L %d %d" stroke="rgb(0,0,255)" stroke-width="1" />\n',x1,y1,x2,y2);
        x1=(m-1)*column_width+vertexgapx; y1=(n-1)*row_height-vertexgapy+extra_height; x2=m*column_width-vertexgapx; y2=(n-1)*row_height+vertex_gap-vertexgapy;
        fprintf(fid,'<path d="M %d %d L %d %d" stroke="rgb(0,0,255)" stroke-width="1" />\n',x1,y1,x2,y2);
      else
        x1=(m-1)*column_width; y1=(n-1)*row_height+vertex_gap+extra_height; x2=(m-1)*column_width; y2=n*row_height-vertex_gap+extra_height;
        fprintf(fid,'<path d="M %d %d L %d %d" stroke="rgb(255,0,0)" stroke-width="1" />\n',x1,y1,x2,y2);
        x1=(m-1)*column_width+vertexgapx; y1=(n-1)*row_height-vertexgapy+extra_height; x2=m*column_width-vertexgapx; y2=(n-1)*row_height+vertex_gap-vertexgapy;
        fprintf(fid,'<path d="M %d %d L %d %d" stroke="rgb(255,0,0)" stroke-width="1" />\n',x1,y1,x2,y2);
      endif
      if n==1, %Bottom little bits
        x1=(m-1)*column_width; y1=vertex_gap; x2=(m-1)*column_width; y2=extra_height-vertex_gap;
        fprintf(fid,'<path d="M %d %d L %d %d" stroke="rgb(0,0,255)" stroke-width="1" />\n',x1,y1,x2,y2);
      endif
    endif
  end
end


fprintf(fid,'\n</g>\n');
fprintf(fid,'</g>\n');
fprintf(fid,'\n</svg>');
fclose(fid);