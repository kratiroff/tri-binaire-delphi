
Binary Search

{
INTERESTING FACT:
A binary search on array of 1 000 000 items will execute the
loop AT MOST 20 times. Here is how the possibilities are eliminated:

1000000 div 2 =
500000 div 2 =
250000 div 2 =
125000 div 2 =
62500 div 2 =
31250 div 2 =
15625 div 2 =
7812 div 2 =
3906 div 2 =
1953 div 2 =
976 div 2 =
488 div 2 =
244 div 2 =
122 div 2 =
61 div 2 =
30 div 2 =
15 div 2 =
7 div 2 =
3 div 2 =
1

This is why its called BINARY SEARCH. 

Ever wondered if there is a quicker way to search for an item in a large array?
Sometimes you have to search for an item in an array that has thousands of
items - and what if the item you are looking for is the last one...
Here is a super fast way of doing it called BINARY SEARCHING.

Binary searching is a search method of dividing the list of possibilities
in two each time the loop is executed. The item in the middle of the
new set of possibilities is then compared with the searched item. If it isn't
a match, the loop is executed again until there is at least only one
possibility left or the item is not found.
The only setback of binary searching is that the list of items needs to
be sorted first.

Here is an example to quicksort the Strings and performed a binary search
on an array of String}



type
  TStringArray = array of string;
  //Start is the index of the first item of the array - usually 0
  //Stop is the index of the last item of the array

procedure QuickSort(var Strings: TStringArray; Start, Stop: Integer);
var
  Left: Integer;
  Right: Integer;
  Mid: Integer;
  Pivot: string;
  Temp: string;
begin
  Left  := Start;
  Right := Stop;
  Mid   := (Start + Stop) div 2;

  Pivot := Strings[mid];
  repeat
    while Strings[Left] < Pivot do Inc(Left);
    while Pivot < Strings[Right] do Dec(Right);
    if Left <= Right then
    begin
      Temp           := Strings[Left];
      Strings[Left]  := Strings[Right]; // Swops the two Strings
      Strings[Right] := Temp;
      Inc(Left);
      Dec(Right);
    end;
  until Left > Right;

  if Start < Right then QuickSort(Strings, Start, Right); // Uses
  if Left < Stop then QuickSort(Strings, Left, Stop);     // Recursion
end;



function BinSearch(Strings: TStringArray; SubStr: string): Integer;
var
  First: Integer;
  Last: Integer;
  Pivot: Integer;
  Found: Boolean;
begin
  First  := Low(Strings); //Sets the first item of the range
  Last   := High(Strings); //Sets the last item of the range
  Found  := False; //Initializes the Found flag (Not found yet)
  Result := -1; //Initializes the Result

  //If First > Last then the searched item doesn't exist
  //If the item is found the loop will stop
  while (First <= Last) and (not Found) do
  begin
    //Gets the middle of the selected range
    Pivot := (First + Last) div 2;
    //Compares the String in the middle with the searched one
    if Strings[Pivot] = SubStr then
    begin
      Found  := True;
      Result := Pivot;
    end
    //If the Item in the middle has a bigger value than
    //the searched item, then select the first half
    else if Strings[Pivot] > SubStr then
      Last := Pivot - 1
        //else select the second half
    else 
      First := Pivot + 1;
  end;
end;




//To use the Binary Search:
procedure Button1Click(Sender: TObject);
var
  MyStrings: TStringArray;
begin
 

  QuickSort(MyStrings, 0, High(MyStrings);
    ShowMessage('The index of 'Derek' is: ' +
    IntToStr(BinSearch(MyStrings, 'Derek')
    //If 'Derek' is in MyStrings, its index value will be returned,
    //otherwise -1 will be returned.
  end;







Directories

Create a Directory : CreateDir('c:\path'); Tip 102 (MkDir Example)
Remove a Directory : RemoveDir('c:\path') or RmDir('c:\path')
Change a Directory : ChDir('c:\path')
Current Directory  : GetCurrentDir
Check if a Directory exists : if DirectoryExists('c:\path') then ...
Rename a Directory: Tip 1024 (SHFileOperation)
Copy/Move/Delete whole directories: Tip 152 (ShFileOperation)

Files
Rename a File : RenameFile('file1.txt', 'file2.xyz')
Delete a File : DeleteFile('c:\text.txt')
Move a File   : MoveFile('C:\file1.txt','D:\file1.txt');
Copy a File   :* CopyFile(Pchar(File1),PChar(File2),bFailIfExists)* Tip 28 (SHFileOperation)
Change a File Extension : ChangeFileExt('test.txt', 'xls')
Check if a File exists : if FileExists('c:\filename.tst') then ...




lance et fin programme : http://www.swissdelphicenter.com/en/showcode.php?id=93



download from intenet : http://www.swissdelphicenter.com/en/showcode.php?id=412



Having given you advice about your data structure, and seen the ensuing struggles, I want to put things straight and explain more clearly what I mean.

You original code had two arrays that were essentially unconnected. You could swap items in one array and easily forget to do so for the other array. It looks to me like the name/age pairs really should not be split apart. This leads to the following type declaration.


type
  TPerson = record
    Name: string;
    Age: Integer;
  end;


Now you need to hold an array of TPerson.

type
  TPersonArray = array of TPerson;

In order to perform a sort you need to be able to compare two items, and swap them.


function Compare(const Person1, Person2: TPerson): Integer;
begin
  Result := CompareText(Person1.Name, Person2.Name);
end;


procedure Swap(var Person1, Person2: TPerson);
var
  temp: TPerson;
begin
  temp := Person1;
  Person1 := Person2;
  Person2 := temp;
end;

Now we can put this all together with a bubble sort.

procedure Sort(var People: TPersonArray);
var
  i, n: Integer;
  Swapped: Boolean;
begin
  n := Length(People);
  repeat
    Swapped := False;
    for i := 1 to n-1 do begin
      if Compare(People[i-1], People[i])>0 then begin
        Swap(People[i-1], People[i]);
        Swapped := True;
      end;
    end;
    dec(n);
  until not Swapped;
end;

Now, if you wanted to use a more complex comparison operator then you could simply replace Compare. For example, if you wanted to order by age any people that have the same name, then you use a lexicographic comparison function.

function Compare(const Person1, Person2: TPerson): Integer;
begin
  Result := CompareText(Person1.Name, Person2.Name);
  if Result=0 then begin
    Result := Person2.Age-Person1.Age;
  end;
end;

