package Mystery_Package with SPARK_Mode is
	  
   subtype It is Integer;  
   
   subtype Pr is Integer;
   
   type El is record
      I: It := Integer'First;                                       
      P: Pr := Integer'First;                             
   end record;
	
   type Mystery_Type is private;
   
   function To_String (I : Integer) return String;
   
   procedure Pnt (MT : in Mystery_Type); 
   
   function Is_Fl (MT : Mystery_Type) return Boolean;
   
   function Ln (MT : Mystery_Type) return Natural;
   
   function Is_Mx_Pr
     (MT : Mystery_Type; 
      P : Pr) 
   return Boolean with Ghost;
   
   function Is_A_E_o_MT
     (MT_Old, MT : Mystery_Type; 
      E : El) 
   return Boolean with Ghost;
   
   function Is_Fst_M_Pr_Ext 
     (MT_Old, MT : Mystery_Type; 
      E : El) 
   return Boolean with Ghost;
   
   procedure Inrt (MT : in out Mystery_Type; E : El) with
     Pre => 
       not Is_Fl (MT),
     Post => 
       Is_A_E_o_MT (MT'Old, MT, E);
  
   procedure Etrt (MT : in out Mystery_Type; E : out El) with
     Pre => 
       Ln(MT) >= 1,
     Post => 
       Is_Mx_Pr (MT, E.P) and then
       Is_Fst_M_Pr_Ext (MT'Old, MT, E);
   
   pragma Annotate (GNATprove, Terminating, Inrt);
   pragma Annotate (GNATprove, Terminating, Etrt);
   
private
   
   subtype Index is Natural range 1 .. 10;     
   
   subtype Extended_Index is Natural range 0 .. Index'Last;
   
   type Contents is array (Index'First .. Index'Last) of El;
   
   type Mystery_Type is record
      Ln : Extended_Index := 0;
      C : Contents;
   end record;

end Mystery_Package;
