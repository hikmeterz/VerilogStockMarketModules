`timescale 1ns / 1ps


module buyuk_borsa(
    input [36:0] yatirimci_kimlikno,
    input [9:0] hisse_numarasi1,
    input [31:0] hisse_deger1,
    input [9:0] hisse_numarasi2,
    input [31:0] hisse_deger2,
    input [9:0] hisse_numarasi3,
    input [31:0] hisse_deger3,
    input [63:0] bakiye,
    
    input [9:0] hisse_numarasi4,
    input [31:0] hisse_deger4,
    input [9:0] hisse_numarasi5,
    input [31:0] hisse_deger5,
    input [9:0] hisse_numarasi6,
    input [31:0] hisse_deger6,
    
    
    input [9:0] hisse_numarasi7,
    input [31:0] hisse_deger7,
    input [9:0] hisse_numarasi8,
    input [31:0] hisse_deger8,
    input [9:0] hisse_numarasi9,
    input [31:0] hisse_deger9,
    
    
    output reg[9:0] karar_no
    
    );
    
    wire [63:0] sifre1;
    wire [15:0] sifre_anahtari1;
    wire [63:0] kagit1;
    
    borsa_guvenli borsa1(.yatirimci_kimlikno(yatirimci_kimlikno),
                         .hisse_numarasi1(hisse_numarasi1),
                         .bakiye(bakiye),
                         .hisse_deger1(hisse_deger1),
                         .hisse_numarasi2(hisse_numarasi2),
                         .hisse_deger2(hisse_deger2),
                         .hisse_numarasi3(hisse_numarasi3),
                         .hisse_deger3(hisse_deger3),
                         .kagit_sayisi(kagit1),
                         .sifre_cikisi(sifre1),
                         .sifre_anahtari(sifre_anahtari1)    
                          );
    
    wire [63:0] sifre2;
    wire [15:0] sifre_anahtari2; 
    wire [63:0] kagit2;
    borsa_guvenli borsa2(.yatirimci_kimlikno(yatirimci_kimlikno),
                         .hisse_numarasi1(hisse_numarasi4),
                         .bakiye(bakiye),
                         .hisse_deger1(hisse_deger4),
                         .hisse_numarasi2(hisse_numarasi5),
                         .hisse_deger2(hisse_deger5),
                         .hisse_numarasi3(hisse_numarasi6),
                         .hisse_deger3(hisse_deger6),
                         .kagit_sayisi(kagit2),
                         .sifre_cikisi(sifre2),
                         .sifre_anahtari(sifre_anahtari2)    
                          );
    
    wire [63:0] sifre3;
    wire [15:0] sifre_anahtari3;
    wire [63:0] kagit3;
    borsa_guvenli borsa3(.yatirimci_kimlikno(yatirimci_kimlikno),
                         .bakiye(bakiye),
                         .hisse_numarasi1(hisse_numarasi7),
                         .hisse_deger1(hisse_deger7),
                         .hisse_numarasi2(hisse_numarasi8),
                         .hisse_deger2(hisse_deger8),
                         .hisse_numarasi3(hisse_numarasi9),
                         .hisse_deger3(hisse_deger9),
                         .kagit_sayisi(kagit3),
                         .sifre_cikisi(sifre3),
                         .sifre_anahtari(sifre_anahtari3)    
                          );
    
    reg [63:0] sifre33;
    reg [63:0] sifre22;
    reg [63:0] sifre11;
    
    reg [15:0] sifre_anahtari33;
    reg [15:0] sifre_anahtari22;
    reg [15:0] sifre_anahtari11;
    
    
    reg [63:0] kagit11;
    reg [63:0] kagit22;
    reg [63:0] kagit33;
    
    //sensity list'e  tekrar kullanmak zorunda olduklarimi almamayi boyle dusundum.
   //* koyunca aralarinda tekrar kulladiklarim oldugu icin yanlis bir sonuc cikarir mi emin olamadim.
    always@(sifre3 or sifre2 or sifre1 or sifre_anahtari1 or sifre_anahtari2 or sifre_anahtari3 or kagit1 or kagit2 or kagit3)begin
        sifre33=sifre3;
        sifre22=sifre2;
        sifre11=sifre1;
        
        sifre_anahtari11=sifre_anahtari1;
        sifre_anahtari22=sifre_anahtari2;
        sifre_anahtari33=sifre_anahtari3;
        
        sifre11=sifre11/sifre_anahtari11;
        sifre22=sifre22/sifre_anahtari22;
        sifre33=sifre33/sifre_anahtari33;
    
        kagit11=kagit1;//Borsalardan(3) elde edilmis kagit sayilari...
        kagit22=kagit2;
        kagit33=kagit3;
        
        
        if(kagit11>kagit22)begin
            if(kagit11>kagit33)begin
                karar_no=sifre11[9:0];
            end
            else if(kagit11<kagit33)begin
                    karar_no=sifre33[9:0];
                    
            end
         end
         else if(kagit11<kagit22)begin
            if(kagit22>kagit33)begin
                karar_no=sifre22[9:0];
                
            end
            else if(kagit22<kagit33)begin
                karar_no=sifre33[9:0];
            end
         end        
        
    end
    
endmodule
