function Log(data)
  dateTime=now;
  dateTime=datestr(dateTime,0);
  fid = fopen('log.txt', 'a+');
  fprintf(fid, '%s\n',dateTime);
  fprintf(fid, '%s\n',mat2str(data));
  fclose(fid);
end
