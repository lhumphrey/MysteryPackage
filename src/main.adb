with Mystery_Package; use Mystery_Package;
with Ada.Text_IO; use Ada.Text_IO;
with Ada.Strings.Fixed; use Ada.Strings.Fixed;


procedure Main is

   procedure Test_Inrt (MT: in out Mystery_Type; E: El) is
   begin
      Put_Line ("--- Apply Inrt ---");
      Inrt (MT, E);
      Put ("MT : ");
      Pnt (MT);
      New_Line (2);
   end Test_Inrt;

   procedure Test_Etrt (MT: in out Mystery_Type) is
      E : El;
   begin
      Put_Line ("--- Apply Etrt ---");
      Etrt (MT, E);
      Put_Line ("E : (" & To_String (E.I) & "," & To_String (E.P) & ")");
      Put ("MT : ");
      Pnt (MT);
      New_Line (2);
   end Test_Etrt;

   MT : Mystery_Type;

begin

   Inrt (MT, (10, -5464));
   Inrt (MT, (25, -2));
   Inrt (MT, (3, 10));

   New_Line;
   Put_Line ("--- Current state ---");
   Put ("MT : ");
   Pnt (MT);
   New_Line (2);

   Test_Inrt (MT, (-2, 17));
   Test_Inrt (MT, (3, 125));
   Test_Inrt (MT, (251, 0));
   Test_Inrt (MT, (18, 18));
   Test_Inrt (MT, (-1, 5));
   Test_Inrt (MT, (73, 42));

   Test_Etrt (MT);
   Test_Etrt (MT);
   Test_Etrt (MT);
   Test_Etrt (MT);
   Test_Etrt (MT);
   Test_Etrt (MT);
   Test_Etrt (MT);
   Test_Etrt (MT);
   Test_Etrt (MT);

end Main;
