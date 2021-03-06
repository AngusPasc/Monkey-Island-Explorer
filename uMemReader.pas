

unit uMemReader;

interface

uses
	Classes, SysUtils;

type
  TExplorerMemoryStream = class (TMemoryStream)

  private

  public
    function ReadByte: byte;
    function ReadWord: word;
    function ReadDWord: longword;
    function ReadBlockName: string;
    function ReadBuffer(var Buffer; Count: longint): longint;
    function ReadString(Length: integer): string;
    function ReadStringAlt(Length: integer): string;
    constructor Create;
    destructor Destroy; override;

end;

implementation

function TExplorerMemoryStream.ReadByte: byte;
begin
	Read(result,1);
end;

function TExplorerMemoryStream.ReadWord: word;
begin
  Read(result,2);
end;

function TExplorerMemoryStream.ReadDWord: longword;
begin
  Read(result,4);
end;

function TExplorerMemoryStream.ReadBlockName: string;
begin
   result:=chr(ReadByte)+chr(ReadByte)+chr(ReadByte)+chr(ReadByte);
end;

function TExplorerMemoryStream.ReadBuffer(var Buffer; Count:longint): longint;
begin
	result:=Read(Buffer,Count);
end;

function TExplorerMemoryStream.ReadString(Length: integer): string;
var
  n: longword;
begin
  SetLength(result,length);
  for n:=1 to length do
  begin
    result[n]:=Chr(ReadByte);
  end;
end;

function TExplorerMemoryStream.ReadStringAlt(Length: integer): string;
var //Replaces #0 chars
  n: longword;
  Rchar: char;
begin
  SetLength(result,length);
  for n:=0 to length -1 do
  begin
    RChar:=Chr(ReadByte);
    if RChar=#0 then
      result[n]:='x'
    else
    result[n]:=rchar;
  end;
end;

constructor TExplorerMemoryStream.Create;
begin
  inherited Create;
end;

destructor TExplorerMemoryStream.Destroy;
begin
  inherited;
end;

end.
