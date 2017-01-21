program contacts;
uses crt;
type
student=record
        std_lname:string;
        std_name:string;
        std_addr:string;
        std_bday:string;
        std_conn:string;
        end;
type
 rec_number=record
            total_rec:longint;
            dummy:string[17];
            end;
     myfilevar=file of student;
var
 answer:char;
 filename:string[20];

 procedure get_record(var std_rec:student);
 var
 tempstd:student;
 begin
 write('Enter last name:  ');
 readln(tempstd.std_lname);
 write('Enter first name:  ');
 readln(tempstd.std_name);
 write('Enter Address:  ');
 readln(tempstd.std_addr);
 write('Enter Birthday(mm\dd\yyyyy):  ');
 readln(tempstd.std_bday);
 write('Enter contact #:  ');
 readln(tempstd.std_conn);
 std_rec.std_lname:=tempstd.std_lname;
 std_rec.std_name:=tempstd.std_name;
 std_rec.std_addr:=tempstd.std_addr;
 std_rec.std_bday:=tempstd.std_bday;
 std_rec.std_conn:=tempstd.std_conn;
 end;

 procedure disp_rec(var filevar:myfilevar);
 var
 temprec:student;
 begin
 read(filevar,temprec);
 writeln('Last name : ',temprec.std_lname);
 writeln('Name : ',temprec.std_name);
 writeln('Address : ',temprec.std_addr);
 writeln('Birthday : ',temprec.std_bday);
 writeln('Contact # : ',temprec.std_conn);
 end;

 procedure create_file;
 var
 temprec:rec_number;
 iook:word;
 openok:boolean;
 answer:char;
 filevar:myfilevar;
 begin
 openok:=true;
 assign(filevar,filename);
 {$I-}
 reset(filevar);
 {$I+}
 iook:=ioresult;
 if iook = 0 then
 begin
 openok:=false;
 write('File ',filename,' already exist!!! overwrite? ');
 readln(answer);
 if upcase(answer) = 'Y' then
   openok:=true;
   end;
   if openok = true then
   begin
   rewrite(filevar);
   close(filevar);
   end;
   end;
   procedure search;
   var
   total_rec:longint;
   filevar:myfilevar;
   iook,rec:word;
   begin
   assign(filevar,filename);
   {$I-}
   reset(filevar);
   {$I+}
   iook:=ioresult;
   if iook <> 0 then
    writeln('Filename ',filename,' not found!!')
    else
    begin
     total_rec:=filesize(filevar);
     writeln('Total Records in file : ',total_rec);
     write('Enter Record number: ');
     readln(rec);
     if (total_rec = 0) or (rec > total_rec ) then
       writeln('Record out of range')
       else
       begin
       seek(filevar,rec-1);
       disp_rec(filevar);
       close(filevar);
       end;
       end;
       end;

       procedure edit;
       var
       total_rec:longint;
       filevar:myfilevar;
       iook,rec:word;
       std_record:student;
       begin
       assign(filevar,filename);
       {$I-}
       reset(filevar);
       {$I+}
       iook:=ioresult;
       if iook <> 0 then
         writeln('Filename ',filename,' not found')
         else
         begin
         total_rec:=filesize(filevar);
         writeln('Total Records in file: ',total_rec);
         write('Enter the record number: ');
         readln(rec);
         if (total_rec = 0) or (rec > total_rec ) then
         writeln('record out of range')
         else
         begin
          seek(filevar,rec-1);
       disp_rec(filevar);
        seek(filevar,rec-1);
        get_record(std_record);
        write(filevar,std_record);
        close(filevar);
        end;
        end;
        end;

        procedure append;
        var
        total_rec:longint;
        filevar:myfilevar;
        std_record:student;
        iook:word;
        begin
        assign(filevar,filename);
       {$I-}
       reset(filevar);
       {$I+}
       iook:=ioresult;
       if iook <> 0 then
       writeln('filename ',filename,' not found.')
       else
       begin
       total_rec:=filesize(filevar);
       writeln('current total record number ',total_rec);
       if total_rec <> 0 then
       begin
       seek(filevar,total_rec-1);
       read(filevar,std_record);
       end;

       get_record(std_record);
       write(filevar,std_record);
       close(filevar);
       end;
       end;

       procedure changefn;
       begin
       write('Enter New filename ');
       readln(filename);
       end;

       begin
       answer:=' ';
       filename:='tpfile.dbf';
       while answer <> '6' do
       begin
       clrscr;
       writeln('Default filename : ',filename);
       writeln('1=create database');
       writeln('2=append record');
       writeln('3=search');
       writeln('4=edit');
       writeln('5=change file name');
       writeln('6=exit');
       writeln;
       writeln;
       write('Please choose a number : ');
       readln(answer);
       case answer of
       '1' :create_file;
       '2' :append;
       '3' :search;
       '4' :edit;
       '5' :changefn;
       end;
       write('Press any key.......');
       readln;
       end;
       end.