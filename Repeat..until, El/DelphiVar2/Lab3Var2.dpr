Program Lab3Var2;
{
 Calculate infinite function Y using precision Eps1 and Eps2.
}

{$APPTYPE CONSOLE}

Const
  Eps1 = 1E-5;
  Eps2 = 1E-6;
  q = 8;
  p = q + 2;
  xStart = 0.1;
  xLast = 0.9;
  xStep = 0.1;
  //Eps1, Eps2 - precision up to which the calculation is made
  //q - an amount of simbols after comma
  //p - an amount of simbols in a number
  //xStart - start value for n,
  //xLast - last value for x,
  //xStep - step to change x.

Var
  x, y, El, Num, Den, Delta: real;
  k: integer;
  FirstAccuracy : boolean;
  //x - function argument
  //y - current function value
  //El - the current value of the element in the function
  //Num - numerator value
  //Den - denomerator value
  //Delta - current precision
  //k - counter for sum
  //FirstAccuracy - flag to determine if the first accuracy is passed

Begin

  //Initialize x
  x:=xStart;

  //Iterate over the value of x
  while x<=xLast do
  begin

    //Display the current value of an argument
    Writeln('For x = ',x:3:1,':');

    //Reset y for the cycle
    y:=0;

    //Initialize variables to count the first element
    k:= 0;
    Num:= x*x*x;
    Den:=(4*k+3)*(4*k+4);

    //To start the cycle, reset FirstAccuracy
    FirstAccuracy:= False;

    repeat

      //Ñount the current value of the element in the function
      El:= Num/Den;

      //Count the current function value
      y:= y + El;

      //Count current precision. This is the modulus of the element,
      //since whith y-yo everything is reduced and the current element remains
      Delta:= abs(El);

      //Check if the first precision is reached
      if (Delta <= Eps1) and (FirstAccuracy = False) then
      begin

        //Displaying the first value of the function with the first precision
        Writeln('Epsilon = ',Eps1:p,' y = ',y:p:q,' k = ',k);

        //Mark that the value with the first precision is already displayed
        FirstAccuracy := True;

      end;

      //Modernze variables for the next iteration
      k:= k + 1;
      Num:= (-1) * x * Num;
      Den:= (4*k+3)*(4*k+4);

    //Since Eps2 is less (need more precision), then in the cycle the condition will be it
    until Delta<= Eps2;

    //Displaying the second value of the function with the second precision
    Writeln('Epsilon = ',Eps2:p,' y = ',y:p:q,' k = ',k-1);
    Writeln;

    //Modernize x
    x:= x + xStep;

  end;

  Readln;
End.
