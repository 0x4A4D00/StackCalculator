program arthmetic;

{$mode objfpc}{$H+}
{$ModeSwitch advancedrecords}

uses
  SysUtils;

type
  TStack = record
    const
      MAX = 100;
    private
      top : integer;
      pstack : array[0..MAX] of string;

    public
      procedure push(input: string);
      function pop: string;
      function toString: string;
      function revers: TStack;

  end;

procedure TStack.push(input: string);
begin
  if (top <> MAX) then
  begin
    pstack[top] := input;
    inc(top);
  end
  else
    writeln('stack is full');
end;

function TStack.pop: string;
begin
  dec(top);
  result := pstack[top];
end;

function TStack.toString: string;
var
  ts : string;
begin



end;

function TStack.revers: TStack;
begin
  result.top := 0;
  while (top <> 0) do
    result.push(pop);
end;

var
  expression : string;
  t : pchar;
  stack : TStack;

//procedure inc(ai: LongInt);
//begin
//
//end;

function PostfixSet(what: TStack): TStack;
var
  i : integer;
  tp, p : string;
  temp, temp1 : TStack;
  ta : array[0..100] of string;
  last : string;

begin
  i := 0;
  temp.top := 0;
  last := '0';
  temp.push('#');
  ta[0] := string.Create('a',2);

  while(what.top <> 0) do
  begin
    //ta[i] := what.pop;
    //inc(i);

    //last := p;
    p := what.pop;

    if (p = '(') then
    begin
      last := '0';
      temp.push(p);

      inc(i);
      ta[i] := p;
    end
    else if (p = ')') then
    begin
      last := '0';
      repeat
        tp := temp.pop;
        if (tp <> '(') then
          result.push(tp);
        dec(i);
      until (ta[i] <> '(');
    end
    else if (p = '^') then
    begin
      last := '0';
      temp.push(p);

      inc(i);
      ta[i] := p;
    end
    else if (p[1] in ['*', '/']) then
    begin
      last := '0';
      if (ta[i][1] in ['^', '*', '/']) then
      begin
        repeat
          tp := temp.pop;
          result.push(tp);
          dec(i);
        until NOT(ta[i][1] in ['^', '*', '/']);
      end;


      inc(i);
      ta[i] := p;
      temp.push(p);
    end

    else if (p[1] in ['+', '-']) then
    begin
      last := '0';
      if (ta[i][1] in ['^', '*', '/', '+', '-']) then
      begin
        repeat
          tp := temp.pop;
          result.push(tp);
          dec(i);
        until NOT(ta[i][1] in ['^', '*', '/', '+', '-']);
      end;


      inc(i);
      ta[i] := p;
      temp.push(p);
    end

    else
    begin
      if NOT(last[1] in ['(', ')', '^', '+', '-', '/', '*']) then
        p := inttostr((last.ToInteger * 10) + strtoint(p));
      last := p;
      result.push(p);

    end;
  end;

  while(temp.top <> 1) do
    result.push(temp.pop);

  //result := temp;

end;

function CalculatePostfix(input: TStack): integer;
var
  num : TStack;
  t : string;
  first, second : integer;
  tempres : integer = 0;
begin
  num.top := 0;
  while (input.top <> 0) do
  begin
    t := input.pop;
    if (t[1] in ['0'..'9']) then
      num.push(t);

    if (t[1] in ['+', '-', '*', '/', '^']) then
    begin
      first  := StrToInt(num.pop);
      second := StrToInt(num.pop);

      case t of
      '+': tempres := (first+second);
      '-': tempres := (first-second);
      '*': tempres := (first*second);
      '/': tempres := (first div second);
      '^': ;
      end;

      num.push(char(tempres + 48));

    end;
  end;

  result := tempres;
end;

var
  a : Tstack;

begin

  readln(expression);
  t := @expression[length(expression)];
  while(t^ in ['(', ')', '^', '0'..'9', '+', '-', '/', '*']) do
  begin
    stack.push(t^);
    dec(t);
  end;

  a := postfixset(stack).revers;

  WriteLn(CalculatePostfix(a));

  readln;
end.

