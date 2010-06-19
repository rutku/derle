import std.stream;
import std.cstream;
import std.array;
import std.file;
import std.process;
import std.string;

string parametre;

void main(string[] args){
  /*
  * -a = Argümanlar. Kullanımı -a -w -L-lncurses -p derle
  * -Y = Yeni proje oluşturur. Kullanımı -Y derle
  * -Yd = Yeni Dosya oluşturur. Kullanımı -Yd dcurses.d
  */
  parametre ~="dmd";
  
 switch (args[1]) {
   case "-a":
     Derle(args);
     break;
   case "-Y":
     ProjeOluştur(args[2]);
     break;
   case "-Yd":
     DosyaOluştur(args[2],args[3]);
     break;
     
    default:
        dout.writefln("-a = Argümanlar. Kullanımı:derle -a -w -L... -p proje");
	dout.writefln("-Y = Yeni proje oluşturur. Kullanımı:derle -Y proje");
	dout.writefln("-Yd = Yeni Dosya oluşturur. Kullanımı: derle -Yd proje.d");
    }
}

void Derle(string[] args){
  /*
  * -p = Projeyi derler. Kullanımı : dmd -a -w -p proje
  * -d = Dosyayı derler. Kullanımı : dmd -a -w -d proje.d
  */
  
    for(int k=0;k<args.length; k++){
	 if(args[k]=="-p"){
	   for(int i = 2;i<k;i++){
	    parametre~=" "~args[i];
	    }
	    ProjeDerle(args[k+1]);
	  }else if(args[k]=="-d"){
	    for(int i = 2;i<k;i++){
	    parametre~=" "~args[i];
	    }
	     DosyaDerle(args[k+1]);
	  }
  }
}

void ProjeDerle(string pAdi){
  if(exists(pAdi)){
    dout.writefln(pAdi~" adlı dizin var");
  }else{
    dout.writefln(pAdi~" adlı dizin yok");
  }
}

void ProjeOluştur(string pAdi){
  string projeDizini = getcwd()~"/"~pAdi;
  mkdir(projeDizini);
  File dosya = new File(projeDizini~"/main.d",FileMode.OutNew);
  dosya.writefln("import std.stdio;");
  dosya.writefln("void main(){");
  dosya.writefln(" writefln('Merhaba');");
  dosya.writefln("}");
  File index = new File(projeDizini~"/index.txt",FileMode.OutNew);
  index.writefln("argümanlar: ");
  index.writefln("derle: main.d");
}

void DosyaDerle(string dAdi){
  parametre~=" "~dAdi;
  system(parametre);
  string çalıştır = replace(dAdi,".d","");
  system("./"~çalıştır);
}
void DosyaOluştur(string dAdi,string pAdi){
  string projeDizini = getcwd()~"/"~pAdi;
  File dosya = new File(projeDizini~"/"~dAdi,FileMode.OutNew);
  dosya.writefln("class "~dAdi~"{");
  dosya.writefln("}");
  File index = new File(projeDizini~"/"~"index.txt",FileMode.Append);
  index.writefln("sınıf: "~dAdi);
}