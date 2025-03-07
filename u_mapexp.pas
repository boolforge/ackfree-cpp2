const
  ADVNAME = 'advname';
  MAPAFILE = 'mapafile';

type
  TMap = array[1..20, 1..12] of Integer;
  TRegion = record
    room: record
      wmap: TMap;
    end;
  end;
  TMapArray = array[1..16, 1..16] of record
    o: Byte;
  end;

var
  chf: File;
  strnum: function(b: Byte): string; // Corrected declaration
  ioresult: Integer;
  region: TRegion;
  xchunkloc, ychunkloc: Integer;
  map: TMapArray;
  pointx, pointy: Integer;
  topx, topy: Integer;
  pointmode: Integer;
  done2: Boolean;

procedure putpixel(x, y: Integer; color: Byte);
begin
  // Implementation of putpixel
end;

procedure say(x, y, color: Integer; msg: string);
begin
  // Implementation of say
end;

function upcase_sync(ch: Char): Char;
begin
  // Implementation of upcase_sync
end;

function readkey: Char;
begin
  // Implementation of readkey
end;

procedure clearscreen;
begin
  // Implementation of clearscreen
end;

procedure cwmap_scrollbars;
begin
  // Implementation of cwmap_scrollbars
end;

procedure previewcells(x, y: Integer);
begin
  // Implementation of previewcells
end;

procedure exportmap(thisregion: Byte);
begin
  assign(chf, ADVNAME + MAPAFILE + strnum(thisregion));
  {$I-} reset(chf); {$I+}
  if ioresult = 0 then
  begin
    for xchunkloc := 1 to 20 do
      for ychunkloc := 1 to 12 do
      begin
        if region.room.wmap[xchunkloc, ychunkloc] <> 0 then
        begin
          {$I-}
          seek(chf, region.room.wmap[xchunkloc, ychunkloc] - 1);
          read(chf, map[2, 2]);
          {$I+}
          for pointx := 0 to 15 do
            for pointy := 0 to 15 do
              putpixel(pointx + (xchunkloc - topx) * 16,
                       pointy + (ychunkloc - topy) * 16,
                       map[2, 2, pointx + 1, pointy + 1].o);
        end;
      end;
    pointmode := 0;
    say(2, 191, 0, 'ESC:EXIT  ARROW KEYS:MOVE');
    repeat
      case upcase_sync(readkey) of
        #27: begin done2 := true; pointmode := 1; end;
        #0: case readkey of
          'H': begin if topy > 1 then dec(topy); pointmode :=  ▋
