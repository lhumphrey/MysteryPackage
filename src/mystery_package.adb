with Ada.Text_IO; use Ada.Text_IO;
with Ada.Strings.Fixed; use Ada.Strings.Fixed;
		
package body Mystery_Package with SPARK_Mode is
  
   function To_String (I : Integer) return String is 
     (Trim(Integer'Image(I), Ada.Strings.Both));
   
   procedure Pnt (MT : in Mystery_Type) is
   begin                    
      Put("[ ");                               
      for I in 1 .. MT.Ln loop
         Put("(" & To_String (MT.C(I).I) & ", " & 
                To_String (MT.C(I).P) & ") ");
      end loop;
      Put("]");
   end Pnt;
	
   function Is_Fl (MT : Mystery_Type) return Boolean is 
     (MT.Ln = MT.C'Last);
   
   function Ln (MT : Mystery_Type) return Natural is (MT.Ln);
   
   function Is_Mx_Pr (MT : Mystery_Type; P : Pr) return Boolean 
   is 
     (for all I in 1 .. MT.Ln => P >= MT.C(I).P);
   
   function Is_A_E_o_MT
     (MT_Old, MT : Mystery_Type; 
      E : El)  
   return Boolean is
     (MT.Ln = MT_Old.Ln + 1 and then
      MT.C(1 .. MT_Old.Ln) = MT_Old.C(1 .. MT_Old.Ln) and then
      MT.C(MT.Ln) = E);
   
   function Is_Fst_M_Pr_Ext 
     (MT_Old, MT : Mystery_Type; 
      E : El)
   return Boolean is 
     (MT.Ln = MT_Old.Ln - 1 and then
     (for some I in 1 .. MT_Old.Ln => 
         E = MT_Old.C(I) and then
         MT.C(1 .. I - 1) = MT_Old.C(1 .. I - 1) and then
         MT.C(I .. MT.Ln) = MT_Old.C(I + 1 .. MT_Old.Ln) and then
         (for all J in 1 .. I-1 => (E.P > MT.C(J).P))));
   
   procedure Inrt (MT : in out Mystery_Type; E : El) is
   begin
      MT.Ln := MT.Ln + 1;
      MT.C(MT.Ln) := E;
   end Inrt;
   
   procedure Etrt (MT : in out Mystery_Type; E : out El) is
      max_index : Index := 1;
      MT_In : constant Mystery_Type := MT;
   begin
      
      for I in 1 .. MT.Ln loop
         if MT.C(I).P > MT.C(max_index).P then
            max_index := I;
         end if;
         pragma Loop_Invariant(for all K in 1..I => 
                                 MT.C(max_index).P >= MT.C(K).P);
         pragma Loop_Invariant(for all K in 1..max_index-1 => 
                                 MT.C(max_index).P > MT.C(K).P);
         pragma Loop_Invariant(max_index in 1 .. I);
     end loop;
      
      E := MT_In.C(max_index);
      
      MT.C(1 .. max_index - 1) := MT_In.C(1 .. max_index - 1);
      MT.C(max_index .. MT.Ln - 1) := MT_In.C(max_index + 1 .. MT.Ln);
      
      MT.Ln := MT.Ln - 1;
      
      -- Assert Post given the exact index for which it holds, then Assert Post.
      -- The second Assert does not prove without this first one.
      pragma Assert (MT.C(1 .. max_index - 1) = 
                       MT_In.C(1 .. max_index - 1) and then
                     MT.C(max_index .. MT.Ln) = 
                       MT_In.C(max_index + 1 .. MT_In.Ln) and then
                     MT_In.C(max_index) = E and then
                     (for all J in 1 .. max_index - 1 => (E.P > MT.C(J).P)));
      
      pragma Assert (for some I in 1 .. MT_In.Ln => 
                       MT.C(1 .. I - 1) = MT_In.C(1 .. I - 1) and then
                     MT.C(I .. MT.Ln) = 
                       MT_In.C(I + 1 .. MT_In.Ln) and then
                     MT_In.C(I) = E and then
                     (for all J in 1 .. I - 1 => (E.P > MT.C(J).P)));
                      
   end Etrt;
     
end Mystery_Package;
