# Lab №3. Iterative calculations
---
### Task:
![The task](https://i.imgur.com/WW9p5wD.png)
> The program сalculates the value of the function f(x,k), with the value of x, changing from xStart = 0.1 to xLast = 0.9 with a step xStep = 0.1 and accuracies ε1 = 10^(-5) and ε2 = 10^(-6) .

#### Language: Delphi

## There are 2 variants: 
## 1)Cycle with a precondition, finding the accuracy is by definition (|y-y0|)
## 2)Cycle with a postcondition, finding the accuracy is based on the current element of the series (modulo)

---
### Algorithm scheme using the first variant: 

![Algorithm scheme using the first variant Part1](https://i.imgur.com/Xw3f4qk.png)

![Algorithm scheme using the first variant Part2](https://i.imgur.com/Q6t6nE6.png)

![Algorithm scheme using the first variant Part3](https://i.imgur.com/iVrg7kG.png)

### Code using the first variant:
``` pascal
Program Lab3Var1;
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
  x, y, y0, Num, Den, Delta: real;
  k: integer;
  FirstAccuracy : boolean;
  //x - function argument
  //y - current function value
  //y0 - previous function value
  //Num - numerator value
  //Den - denomerator value
  //Delta - current precision
  //k - counter for sum
  //FirstAccuracy - flag to determine if the first accuracy is passed

Begin

  //Initialize x
  x:= xStart;

  //Iterate over the value of x
  while x<=xLast do
  begin

    //Display the current value of an argument
    Writeln('For x = ',x:3:1,':');

    //Since there is no previous function value, y0:= 0
    y0:= 0;

    //Initialize variables to count the first element
    k:= 0;
    Num:= x*x*x;
    Den:=(4*k+3)*(4*k+4);

    //To start the cycle, reset FirstAccuracy
    FirstAccuracy:= False;

    //Since a cycle with a precondition is used,
    //to enter the cycle, need to do the following:
    Delta:= Eps2 + 1;

    //Since Eps2 is less (need more precision), then in the cycle the condition will be it
    while Delta > Eps2 do
    begin

      //Сount the current value of the function
      y:= y0 + Num/Den;

      //Count current precision
      Delta:= abs(y - y0);

      //Check if the first precision is reached
      if (Delta <= Eps1) and (FirstAccuracy = False) then
      begin

        //Displaying the first value of the function with the first precision
        Writeln('Epsilon =',Eps1:p,' y = ',y:p:q,'  k = ',k);

        //Mark that the value with the first precision is already displayed
        FirstAccuracy := True;

      end;

      //Modernze variables for the next iteration
      y0:= y;
      k:= k + 1;
      Num:= (-1) * x * Num;
      Den:= (4*k+3)*(4*k+4);

    end;

    //Displaying the second value of the function with the second precision
    Writeln('Epsilon =',Eps2:p,' y = ',y:p:q,'  k = ',k-1);
    Writeln;

    //Modernize x
    x:= x + xStep;

  end;

  Readln;
End.
```
---

### Algorithm scheme the second variant:

![Algorithm scheme using the second variant Part1](https://i.imgur.com/J5JG1k6.png)

![Algorithm scheme using the second variant Part2](https://i.imgur.com/4rQq0Et.png)

![Algorithm scheme using the second variant Part3](https://i.imgur.com/cmzCJNv.png)

### Code using the second variant:
``` pascal
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

      //Сount the current value of the element in the function
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
```