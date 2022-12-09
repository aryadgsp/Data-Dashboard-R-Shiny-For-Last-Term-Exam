## Shiny UI component for the Dashboard

dashboardPage(
  
  dashboardHeader(title="Dashboard Kelompok G", titleWidth = 230),
  
  
  dashboardSidebar(
    sidebarMenu(id = "sidebar",
      menuItem("Introduction", tabName = "latar", icon = icon("dashboard")),
      menuItem("Dataset", tabName = "data", icon = icon("database")),
      menuItem("Visualization", tabName = "viz", icon=icon("chart-line")),
      
      # Conditional Panel for conditional widget appearance
      # Filter should appear only for the visualization menu and selected tabs within it
      conditionalPanel("input.sidebar == 'viz' && input.t2 == 'distro'", selectInput(inputId = "var1" , label ="Select the Variable" , choices = c3)),
      conditionalPanel("input.sidebar == 'viz' && input.t2 == 'trends' ", selectInput(inputId = "var2" , label ="Select the Arrest type" , choices = c2)),
      conditionalPanel("input.sidebar == 'viz' && input.t2 == 'relation' ", selectInput(inputId = "var3" , label ="Select the X variable" , choices = c1, selected = "Waktu")),
      conditionalPanel("input.sidebar == 'viz' && input.t2 == 'relation' ", selectInput(inputId = "var4" , label ="Select the Y variable" , choices = c1, selected = "Wishlist")),
      menuItem("Interpretation", tabName = "interpretasi", icon=icon("book"))
      
    )
  ),
  
  
  dashboardBody(
    
    tabItems(
      # Zero tab item
      tabItem(
        tabName = "latar",
        fluidRow(
          verbatimTextOutput(outputId = "latar"),
          HTML("<h1><b>Latar Belakang</b></h1>
               <hr>
               <p style='font-size:20px'>Dengan teknologi yang semakin berkembang maka sekarang ini banyak situs situs jual beli online
               dimana dalam didalamnya mengumpulkan banyak online shop menjadi satu situs yang mempermudah pembeli
               untuk mendapatkan barang yang mereka inginkan. Kecanggihan yang disuguhkan ini, salah satunya mengakibatkan
               peningkatan daya beli masyarakat hingga pergeseran budaya belanja, dari belanja konvensional ke belanja
               secara online melalui e-commerce.  Keadaan inilah yang secara tidak langsung akan membentuk kecenderungan perilaku konsumtif.
               </p>
               <p style='font-size:20px'>Tim melihat bahwa banyaknya masyarakat yang sangat memanfaatkan e-commerce hanya sebagai konsumen. konsumen,
               tidak hanya untuk menambah penghasilan. Konsumen seringnya mengeluh karena tidak bisa mengendalikan perilaku
               konsumtifnya. Dampak dari perilaku konsumtif juga tidak baik karena akan melemahkan perekonomian individu.
               Gaya hidup konsumtif banyak dijumpai pada kalangan generasi muda yang tujuannya sering ditunjukkan pada hal
               hal yang berkaitan dengan kesenangan dan kepuasan dalam mengkonsumsi barang secara berlebihan. Mahasiswa merupakan
               peralihan individu dari fase remaja menuju dewasa yang cenderung terbujuk oleh hal-hal yang menyenangkan sehingga
               mahasiswa dijadikan sasaran pemasaran berbagai produk dan akibatnya mendorong timbulnya berbagai gejala perilaku
               pembelian yang tidak wajar, dan mahasiswa lah yang dijadikan target dalam analisis ini.
               </p>
               <p style='font-size:20px'>Sejalan dengan fakta tersebut, analisis ini kami lakukan untuk mengetahui:</p>
               <ul>
                <li style='font-size:20px'>Seberapa besar pengaruh e-commerce terhadap perilaku konsumtif mahasiswa Universitas Airlangga</li>
                <li style='font-size:20px'>Hubungan faktor-faktor yang diperkirakan dapat mempengaruhi perilaku konsumtif mahasiswa Universitas Airlangga</li>
               </ul>")
        )
      ),
      
      
      ## First tab item
      tabItem(tabName = "data", 
              tabBox(id="t1", width = 12, 
                     tabPanel("About", icon=icon("address-card"),
fluidRow(
  column(width = 7, tags$img(src="ecom.png", width =600 , height = 350),
         tags$br() , 
         tags$a("Photo by Google"), align = "center"),
  column(width = 4, tags$br() ,
         tags$p("Data ini didapat dari survey yang dilakukan oleh Kelompok G dalam rangka pengerjaan final project Ujian Akhir Semester mata kuliah Eksplorasi dan Viualisasi Data kelas SD-A1. Sampel data ini didapat menggunakan metode convenience sampling pada populasi mahasiswa Universitas Airlangga. Data yang terkumpul sebanyak 70 baris data yang kemudian dilakukan pre-processing berupa penghilangan anomali (influential observation) dan penghapusan outlier. Sehingga didapat jumlah data sebanyak 48 baris data yang akan ditampilkan pada dashboard ini. Data ini terdiri dari 10 kolom. Yakni  variabel E.Commerce, Waktu, Wishlist, Internet, Pemasukan, Pengeluaran, beli_berdasarkan_keinginan, beli_untuk_pujian, beli_tanpa_pertimbangkan_uang, dan Konsumtif.")
  )
)

                              
                              ), 
                     tabPanel("Data", dataTableOutput("dataT"), icon = icon("table")), 
                     tabPanel("Structure", verbatimTextOutput("structure"), icon=icon("uncharted")),
                     tabPanel("Summary Stats", verbatimTextOutput("summary"), icon=icon("chart-pie"))
              )

),  
    
# Second Tab Item
    tabItem(tabName = "viz", 
            tabBox(id="t2",  width=12, 
                   tabPanel("E-Commerce Trends by User", value="trends",
                            fluidRow(tags$div(align="center", box(tableOutput("top5"), title = textOutput("head1") , collapsible = TRUE, status = "primary",  collapsed = TRUE, solidHeader = TRUE)),
                                     tags$div(align="center", box(tableOutput("low5"), title = textOutput("head2") , collapsible = TRUE, status = "primary",  collapsed = TRUE, solidHeader = TRUE))
                                     
                            ),
                            withSpinner(plotlyOutput("bar"))
                   ),
            tabPanel("Distribution", value="distro",
                     withSpinner(plotlyOutput("histplot", height = "350px"))),
            tabPanel("Correlation Matrix", width = "800px", height = "800", id="corr" , withSpinner(plotlyOutput("cor"))),
            tabPanel("Relationship among Variable", 
                     radioButtons(inputId ="fit" , label = "Select smooth method" , choices = c("loess", "lm"), selected = "lm" , inline = TRUE), 
                     withSpinner(plotlyOutput("scatter")), value="relation"),
            side = "left"
                   ),
            
            
            ),

   
    # Third Tab Item
      tabItem(
      tabName = "interpretasi",
        fluidRow(
          verbatimTextOutput(outputId = "interpretasi"),
          HTML("<h1><b>Interpretasi</b></h1>
          
                <ol type='A' style='bold'>
                  
                  <h3><b><li>Boxplot</li></b></h3>
                    <p style='font-size:20px'>Setelah dilakukan preprocessing berupa penghilangan anomali dan outlier, seluruh variabel numerik tidak memiliki outlier. Terlihat pada boxplot yang tidak menunjukkan nilai observasi di luar nilai IQR.</p>
                  
                  <h3><b><li>Histogram</li></b></h3>
                    
                    <h4><b>Waktu</b></h4>
                      <p style='font-size:20px'>Dengan histogram tersebut kita dapat melihat berapa rentang waktu yang biasanya dihabiskan per minggu untuk e-commerce , jumlah terbanyak yakni 15 responden yang menggunakan waktunya dalam rentang 0.75-1.24  jam.</p>
                    
                    <h4><b>Wishlist</b></h4>
                      <p style='font-size:20px'>dengan histogram tersebut kita dapat mengetahui jumlah wishlist yang ada pada e-commerce yang paling sering digunakan , jumlah terbanyak yakni dari 0 hingga 12 wishlist oleh 22 orang responden. Kemudian dua orang dari beberapa responden itu, memiliki  wishlist lebih dari 100.</p>
                    
                    <h4><b>Internet</b></h4>
                      <p style='font-size:20px'>dengan histogram tersebut kita dapat mengetahui biaya untuk internet setiap responden dalam 1 bulan terakhir , jumlah terbanyak yakni dari 40ribu  hingga 59ribu  rupiah oleh 20 orang responden. Sedikit sekali responden yang mengeluarkan uang lebih dari 100rb untuk biaya internet di bulan terakhir.</p>
                    
                    <h4><b>Pemasukan</b></h4>
                      <p style='font-size:20px'>terlihat dari histogram bahwa jumlah pemasukan tertinggi responden itu terletak antara 1.5 hingga 1.9 juta, sebanyak 10 orang responden. Hanya dua responden yang memiliki pemasukan diatas tiga juta setiap bulannya.</p>
                    
                    <h4><b>Pengeluaran</b></h4>
                      <p style='font-size:20px'>terlihat dari histogram bahwa jumlah pengeluaran tertinggi responden dalam satu bulan terakhir untuk belanja online terletak antara 100ribu hingga 190ribu yakni sebanyak 15 orang responden. Hanya dua responden yang satu orang yang menghabiskan biaya diatas 600ribu sebagai pengeluaran tertinggi</p>
                    
                  
                  <h3><b><li>Heatmap</li></b></h3>
                    <p style='font-size:20px'>Korelasi positif ditampilkan pada warna merah, sedangkan korelasi sempurna dengan slope negatif  disajikan pada warna biru. Semakin kecil korelasinya maka semakin pudar warna pada matriks tersebut. Korelasi positif tertinggi terdapat pada hubungan antara variabel 'Konsumtif' dengan variabel 'beli_tanpa_pertimbangan_uang' sebesar 0.9. Kemudian disusul oleh hubungan antara variabel 'pengeluaran' dan 'pemasukan', serta variabel 'pengeluaran' dan 'internet' sebesar 0.3. Sedangakn untuk korelasi negatif terbesar terdapat pada variabel 'pemasukan' dan 'waktu' sebesar -0.3</p>
                  
                  <h3><b><li>Scatterplot</li></b></h3>
                    <h4><b>Waktu - Wishlist :</b></h4>
                      <p style='font-size:20px'>Dilihat dari bentuk garisnya yang mengarah ke kanan atas menunjukkan bahwa kedua variabel memiliki hubungan positif, Pola titik pada plot tidak saling berdekatan berartikan bahwa korelasinya tergolong lemah</p>
                    
                    <h4><b>Waktu - Internet :</b></h4>
                      <p style='font-size:20px'>Dilihat dari bentuk garisnya yang mengarah ke kanan bawah menunjukkan bahwa kedua variabel memiliki hubungan negatif, Pola titik pada plot tersebar berartikan bahwa korelasi antara waktu penggunaan ecommerce dengan biaya pengeluaran internet tergolong lemah</b></h4>
                    
                    <h4><b>Waktu - Pemasukan :</b></h4>
                      <p style='font-size:20px'>Dilihat dari bentuk garisnya yang mengarah ke kanan bawah menunjukkan bahwa kedua variabel memiliki hubungan negatif, Pola titik pada plot tidak saling berdekatan alias tersebar berartikan bahwa korelasi ini  tergolong lemah</p>
                    
                    <h4><b>Waktu - Pengeluaran :</b></h4>
                      <p style='font-size:20px'>Dilihat dari bentuk garisnya yang mengarah ke kanan atas menunjukkan bahwa kedua variabel memiliki hubungan positif, Pola titik pada plot yang tersebar berartikan bahwa korelasinya tergolong lemah</p>
                    
                    <h4><b>Wishlist - Waktu :</b></h4>
                      <p style='font-size:20px'>Garisnya yang mengarah ke kanan atas menunjukkan bahwa kedua variabel memiliki hubungan positif, Pola titik pada plot tidak saling berdekatan berartikan bahwa korelasi kedua varibel ini tergolong lemah</p>
                    
                    <h4><b>Wishlist - Internet :</b></h4>
                      <p style='font-size:20px'>Dilihat dari bentuk garisnya yang mengarah ke kanan bawah menunjukkan bahwa kedua variabel memiliki hubungan negatif, Pola titik pada plot tersebar berartikan bahwa korelasi antara jumlah wishlist dengan biaya pengeluaran internet tergolong lemah</p>
                    
                    <h4><b>Wishlist - Pemasukan :</b></h4>
                      <p style='font-size:20px'>Garisnya yang mengarah ke kanan atas menunjukkan bahwa kedua variabel memiliki hubungan positif, artinya terdapat hubungan antara jumlah wishlist dengan besarnya pemasukan. Pola titik pada plot tidak saling berdekatan berartikan bahwa korelasi kedua varibel ini tergolong lemah</p>
                    
                    <h4><b>Wishlist - Pengeluaran :</b></h4>
                      <p style='font-size:20px'>Garisnya yang mengarah ke kanan atas menunjukkan bahwa kedua variabel memiliki hubungan positif, Pola titik pada plot tidak saling berdekatan berartikan bahwa korelasi antara jumlah wishlist dengan besarnya pengeluaran tergolong lemah</p>
                    
                    <h4><b>Internet - Waktu :</b></h4>
                      <p style='font-size:20px'>Dilihat dari bentuk garisnya yang mengarah ke kanan bawah menunjukkan bahwa kedua variabel memiliki hubungan negatif, Pola titik pada plot tersebar berartikan bahwa korelasi antara biaya pengeluaran internet dengan waktu penggunaan ecommerce tergolong lemah</p>
                    
                    <h4><b>Internet - Wishlist :</b></h4>
                      <p style='font-size:20px'>Dilihat dari bentuk garisnya yang mengarah ke kanan bawah menunjukkan bahwa antara variabel internet dan jumlah wishlist memiliki hubungan negatif, Pola titik pada plot tersebar berartikan bahwa korelasi antara kedua variabel ini tergolong lemah</p>
                    
                    <h4><b>Internet - Pemasukan :</b></h4>
                      <p style='font-size:20px'>Dilihat dari bentuk garisnya yang mengarah ke kanan bawah menunjukkan bahwa antara biaya penggunaan internet dan besarnya pemasukan memiliki hubungan negatif, Pola titik pada plot tersebar berartikan bahwa korelasi antara kedua variabel ini tergolong lemah</p>
                    
                    <h4><b>Internet - Pengeluaran :</b></h4>
                      <p style='font-size:20px'>Garisnya yang mengarah ke kanan atas menunjukkan bahwa antara biaya untuk internet memiliki hubungan positif dengan besarnya pengeluaran untuk e-commerce</p>
                    
                    <h4><b>Pemasukan - Waktu :</b></h4>
                      <p style='font-size:20px'>Dilihat dari bentuk garisnya yang mengarah ke kanan bawah menunjukkan bahwa  besarnya pemasukan dengan waktu yang digunakan untuk  e-commerce memiliki hubungan negatif, Pola titik pada plot tidak saling berdekatan alias tersebar berartikan bahwa korelasi ini  tergolong lemah</p>
                    
                    <h4><b>Pemasukan - Wishlist :</b></h4>
                      <p style='font-size:20px'>Dilihat dari bentuk garisnya yang mengarah ke kanan atas menunjukkan bahwa kedua variabel memiliki hubungan positif, Pola titik pada plot tidak saling berdekatan berartikan bahwa korelasi antaran varibel pemasukan dengan jumlah wishlist ini tergolong lemah</p>
                    
                    <h4><b>Pemasukan - Internet :</b></h4>
                      <p style='font-size:20px'>Dilihat dari bentuk garisnya yang mengarah ke kanan bawah menunjukkan bahwa antara kedua variabel memiliki hubungan negatif, Pola titik pada plot tersebar berartikan bahwa korelasi antara besarnya pemasukan dengan besarnya biaya internet ini tergolong lemah </p>
                    
                    <h4><b>Pemasukan - Pengeluaran :</b></h4>
                      <p style='font-size:20px'>Dilihat dari bentuk garisnya yang mengarah ke kanan atas menunjukkan bahwa besarnya pemasukan memiliki hubungan positif dengan besarnnya pengeluaran untuk berbelanja di e-commerce. Pola titik pada plot tidak saling berdekatan berartikan bahwa korelasi antar varibel tergolong lemah.</p>
                    
                    <h4><b>Pengeluaran - Waktu :</b></h4>
                      <p style='font-size:20px'>Dilihat dari bentuk garisnya yang mengarah ke kanan atas menunjukkan bahwa kedua variabel memiliki hubungan positif. Pola titik pada plot yang tersebar berartikan bahwa korelasi antara pengeluaran untuk belanja online dengan waktu yang digunakan dalam menggunakan ecommerce tergolong lemah.</p>
                    
                    <h4><b>Pengeluaran - Wishlist :</b></h4>
                      <p style='font-size:20px'>Garisnya yang mengarah ke kanan atas menunjukkan bahwa jumlah pengeluaran untuk e-commerce memiliki hubungan positif dengan jumlah wishlist. Pola titik pada plot tidak saling berdekatan berartikan bahwa korelasi antara kedua variabel tergolong lemah.</p>
                    
                    <h4><b>Pengeluaran - Internet :</b></h4>
                      <p style='font-size:20px'>Garisnya yang mengarah ke kanan atas menunjukkan bahwa antara biaya untuk internet memiliki hubungan positif dengan besarnya pengeluaran untuk e-commerce. Pola titik pada plot tersebar berartikan bahwa korelasian ini tergolong lemah.</p>
                    
                    <h4><b>Pengeluaran - Pemasukan :</b></h4>
                      <p style='font-size:20px'>Dilihat dari bentuk garisnya yang mengarah ke kanan atas menunjukkan bahwa antara kedua varibel memiliki hubungan positif. Pola titik pada plot tidak saling berdekatan berartikan bahwa korelasi antara pengeluaran bellanja e-commerce dengan jjumlah pemasukan ini tergolong lemah.</p>
                    
                  
                </ol>")
        )


      
    )

)
    )
  )

  
  
