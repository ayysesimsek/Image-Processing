function varargout = untitled2(varargin)
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @untitled2_OpeningFcn, ...
                   'gui_OutputFcn',  @untitled2_OutputFcn, ...
                   'gui_LayoutFcn',  [] , ...
                   'gui_Callback',   []);
if nargin && ischar(varargin{1})
    gui_State.gui_Callback = str2func(varargin{1});
end

if nargout
    [varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
else
    gui_mainfcn(gui_State, varargin{:});
end


function untitled2_OpeningFcn(hObject, eventdata, handles, varargin)
handles.output = hObject;
guidata(hObject, handles);


function varargout = untitled2_OutputFcn(hObject, eventdata, handles) 
varargout{1} = handles.output;


function Resimyukle_Callback(hObject, eventdata, handles)
global image
global filename
global pathname

[filename, pathname] = uigetfile('*','Resim dosyasýný seçiniz:'); 
fullPathName =strcat( pathname, filename);
image=imread(fullPathName);

axes(handles.axes2);
imshow(image);
height = size(image,1);
width = size(image,2);

%Burada groupbox içerisindeki oushbuttonlarýn enabled larýnýn aktifleþmesi
%saðlanmaktadýr. GUI ekrNý ilk yüklenirken bu elementler enable özelliði
%Off olarak gelmekte ve resim seçildiði an iþlemin yapýlmasý için enabl On
%hale getirilir.
set(handles.EsiklemeButton, 'enable', 'on');
set(handles.LogButton, 'enable', 'on');
set(handles.GriButton, 'enable', 'on');
set(handles.kontrastGermeButton, 'enable', 'on');
set(handles.HistogramEsitlemeButton, 'enable', 'on');
set(handles.btnMean, 'enable', 'on');
set(handles.btnMedian, 'enable', 'on');
set(handles.btnGauss, 'enable', 'on');
set(handles.btnSobel, 'enable', 'on');
set(handles.btnPrewitt, 'enable', 'on');
set(handles.btnLaplace, 'enable', 'on');

%Burada histogram ve kontrast için kullanýlacak olan axes ler
%gizlenilmektedir. Ayný zmaanda resmin adý, yolu ve geniþlik-yükseklik
%bilgileri ekranda static text üzerine yazdýrýlmaktadýr. 
set(handles.axes7, 'visible','off');
set(handles.axes8, 'visible','off'); 
set(handles.editresimadi, 'String', filename);
set(handles.editresimyolu, 'String', pathname);
set(handles.txt_Genislik, 'String', width);
set(handles.txt_Yukseklik, 'String', height);

% Seçilen Resmin adý ve yolunun dosyaya kaydedilmesi saðlanýlýyor. 
fid = fopen('myfile.txt','a');
fprintf(fid,'Resim Adý : %s \n',filename);
fprintf(fid,'Resmin Yolu : %s \n',pathname);
fprintf(fid,'********************************************************************** \n');
fclose(fid);


% --- Executes on button press in btnMean.
function btnMean_Callback(hObject, eventdata, handles)
global image

mean = str2double(get(handles.edit_mean,'String'));
if(mean>=0 && mean<=3)
    axes(handles.axes3);
    imshow(image);
    axes(handles.axes4);
    imshow(meanFonksiyon(image, mean));
elseif(mean>3)
    msgbox('3 ten büyük deðer giremezsiniz ! ', 'BÝLGÝLENDÝRME', 'warn');
elseif(mean < 0)
    msgbox('Negatig bir deðer giremezsiniz ! Lütfen girdiðiniz deðer 0 dan büyük bir deðer almalýdýr. ');
else
    msgbox('Lütfen filtre boyutunu giriniz. Aksi taktirde resim de iþlem gerçekleþtiremezsiniz !  ', 'MEAN BÝLGÝLENDÝRME', 'warn');
end


% --- Executes on button press in btnMedian.
function btnMedian_Callback(hObject, eventdata, handles)
global image

median = str2double(get(handles.edit_median,'String'));
if(median>=0 && median<=3)
    axes(handles.axes3);
    imshow(image);
    axes(handles.axes4);
    imshow(MedianFonksiyon(image, median));
elseif(median>3)
    msgbox('3 ten büyük deðer giremezsiniz ! ', 'BÝLGÝLENDÝRME', 'warn');
elseif(median < 0)
    msgbox('Negatig bir deðer giremezsiniz ! Lütfen girdiðiniz deðer 0 dan büyük bir deðer almalýdýr. ');
else
    msgbox('Lütfen filtre boyutunu giriniz. Aksi taktirde resim de iþlem gerçekleþtiremezsiniz !  ', 'MEDIAN BÝLGÝLENDÝRME', 'warn');
end


% --- Executes on button press in btnGauss.
function btnGauss_Callback(hObject, eventdata, handles)
global image
 
gauss = str2double(get(handles.edit_gauss,'String'));
if(gauss>=0 && gauss<=3)
    axes(handles.axes3);
    imshow(image);
    axes(handles.axes4);
    imshow(GaussFonksiyon(image, gauss));
elseif(gauss>3)
    msgbox('3 ten büyük deðer giremezsiniz ! ', 'BÝLGÝLENDÝRME', 'warn');
elseif(gauss < 0)
    msgbox('Negatig bir deðer giremezsiniz ! Lütfen girdiðiniz deðer 0 dan büyük bir deðer almalýdýr. ');
else
    msgbox('Lütfen parametre giriþi yapýnýz! ', 'GAUSS BÝLGÝLENDÝRME', 'warn');
end


% --- Executes on button press in btnSobel.
function btnSobel_Callback(hObject, eventdata, handles)
global image

sobel = str2double(get(handles.edit_sobel,'String'));
if(sobel>=0 && sobel<=3)
    axes(handles.axes3);
    imshow(image);
    axes(handles.axes4);
    imshow(SobelFonksiyon(image, sobel));
elseif(sobel>3)
    msgbox('3 ten büyük deðer giremezsiniz ! ', 'BÝLGÝLENDÝRME', 'warn');
elseif(sobel < 0)
    msgbox('Negatif bir deðer giremezsiniz ! Lütfen girdiðiniz deðer 0 dan büyük bir deðer almalýdýr. ');
else
    msgbox('Lütfen filtre boyutunu giriniz. Aksi taktirde resim de iþlem gerçekleþtiremezsiniz !  ', 'SOBEL BÝLGÝLENDÝRME', 'warn');
end



% --- Executes on button press in btnPrewitt.
function btnPrewitt_Callback(hObject, eventdata, handles)
global image

prewitt = str2double(get(handles.edit_prewitt,'String'));
if(prewitt>=0 && prewitt<=3)
    axes(handles.axes3);
    imshow(image);
    axes(handles.axes4);
    imshow(PrewittFonksiyon(image, prewitt));
elseif(prewitt>3)
    msgbox('3 ten büyük deðer giremezsiniz ! ', 'BÝLGÝLENDÝRME', 'warn');
elseif(prewitt < 0)
    msgbox('Negatig bir deðer giremezsiniz ! Lütfen girdiðiniz deðer 0 dan büyük bir deðer almalýdýr. ');
else
    msgbox('Lütfen filtre boyutunu giriniz. Aksi taktirde resim de iþlem gerçekleþtiremezsiniz !  ', 'PREWITT BÝLGÝLENDÝRME', 'warn');
end


% --- Executes on button press in btnLaplace.
function btnLaplace_Callback(hObject, eventdata, handles)
global image

laplace = str2double(get(handles.edit_laplace,'String'));
if(laplace>=0 && laplace<=3)
    axes(handles.axes3);
    imshow(image);
    axes(handles.axes4);
    imshow(LaplaceFonksiyon(image, laplace));
elseif(laplace>3)
    msgbox('3 ten büyük deðer giremezsiniz ! ', 'BÝLGÝLENDÝRME', 'warn');
elseif(laplace < 0)
    msgbox('Negatig bir deðer giremezsiniz ! Lütfen girdiðiniz deðer 0 dan büyük bir deðer almalýdýr. ');
else
    msgbox('Lütfen filtre boyutunu giriniz. Aksi taktirde resim de iþlem gerçekleþtiremezsiniz !  ', 'LAPLACE BÝLGÝLENDÝRME', 'warn');
end



% --- Executes on button press in btnRoberts.
function btnRoberts_Callback(hObject, eventdata, handles)
global image

axes(handles.axes3);
imshow(image);

axes(handles.axes4);
imshow(Roberts(image, 0.05));

%Show final edge detection result

% --- Executes on button press in EsiklemeButton.
function EsiklemeButton_Callback(hObject, eventdata, handles)
global image

axes(handles.axes3);
imshow(image);
axes(handles.axes4);
imshow(convert2binary(image));


% --- Executes on button press in LogButton.
function LogButton_Callback(hObject, eventdata, handles)
global image
log = str2double(get(handles.edit_log,'String'));
if(log>=0)
    axes(handles.axes3);
    imshow(image);
    axes(handles.axes4);
    imshow(LogTransform(image, log), []);
else
    msgbox('Lütfen parametre giriþi yapýnýz! ', 'LOG BÝLGÝLENDÝRME', 'warn');
end



% --- Executes on button press in GriButton.
function GriButton_Callback(hObject, eventdata, handles)
global image   

axes(handles.axes3);
imshow(image);

axes(handles.axes4);
imshow(GrayCevir(image));


% --- Executes on button press in kontrastGermeButton.
% Kontrast Germe
function kontrastGermeButton_Callback(hObject, eventdata, handles)
global image

axes(handles.axes3);
imshow(image);
axes(handles.axes4);
imhist(image);

axes(handles.axes7);
imshow(uint8(KontrastGerme(image)));
axes(handles.axes8);
imhist(KontrastGerme(image));


% --- Executes on button press in HistogramEsitlemeButton.
function HistogramEsitlemeButton_Callback(hObject, eventdata, handles)
global image

% Burada visible ayarýný yapma sebebim þudur; histogram grafiðini
% çizdirirken orjinal resim ve grafiði ve sonrasýnda da oluþan reism ve
% grafiðini belirtmek için 2 axes daha eklenildi. Bu axesler diðer
% panellerdeki pushbuttonlarda görünmemekle birlikte sadece histogram
% eþitleme de ihtiyaçtan doðan sebeple bu þekilde eklenilmesi
% düþünülmüþtür.
set(handles.axes7, 'visible','on');
set(handles.axes8, 'visible','on');

%Burada orjinal resim ve histogram grafiði gösterilmektedir. 
axes(handles.axes3);
imshow(image);
axes(handles.axes4);
imhist(image);

%Burada Histogram eþitleme sonucu oluþan resim ve grafiði gösterilmiþtir.
axes(handles.axes7);
imshow(uint8(HistogramEsitleme(image)));
axes(handles.axes8);
imhist(HistogramEsitleme(image));


% --- Executes on button press in PictureSave.
function PictureSave_Callback(hObject, eventdata, handles)
[FileName, PathName] = uiputfile('*','Kayýt Ekleme', 'Kaydet');
Name = fullfile(PathName,FileName);
F=getframe(handles.axes4);
W=frame2im(F);
imwrite(W, Name, 'tif');


% --------------------------------------------------------------------
function islemlerMenu_Callback(hObject, eventdata, handles)


% --------------------------------------------------------------------
function noktaBazliIslemler_Callback(hObject, eventdata, handles)
set(handles.noktaBazliGroup, 'visible', 'on');

% --------------------------------------------------------------------
function filtreIslemleri_Callback(hObject, eventdata, handles)
set(handles.filtreGroup, 'visible', 'on');

% --------------------------------------------------------------------
function morfolojikIslemler_Callback(hObject, eventdata, handles)
set(handles.morfolojikGroup, 'visible', 'on');

% --------------------------------------------------------------------
function goruntuSikistirmaIslemleri_Callback(hObject, eventdata, handles)
set(handles.sikistirmaGroup, 'visible', 'on');


% --- Executes on selection change in popup_Morfolojik.
function popup_Morfolojik_Callback(hObject, eventdata, handles)
global image
morfolojikIslemler = get(handles.popup_Morfolojik, 'Value');
switch(morfolojikIslemler)
    case 2
        axes(handles.axes3);
        imshow(image);
        axes(handles.axes4);
        imshow(Erosion(image));
    case 3
        axes(handles.axes3);
        imshow(image);
        axes(handles.axes4);
        imshow(Genisleme(image));
    case 4
        axes(handles.axes3);
        imshow(image);
        axes(handles.axes4);
        imshow(Opening(image));
    case 5
        se = strel('disk',10);
        closeBW = imclose(image,se); 
        axes(handles.axes3);
        imshow(image);
        axes(handles.axes4);
        imshow(closeBW);
    otherwise
end


% --- Executes during object creation, after setting all properties.
function popup_Morfolojik_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in popupSikistirma.
function popupSikistirma_Callback(hObject, eventdata, handles)
global image
global pathname
global filename

goruntuSikistirma = get(handles.popupSikistirma, 'Value');
switch(goruntuSikistirma)
    case 2
        axes(handles.axes3);
        imshow(image);
        axes(handles.axes4);
        imshow(DCT(image));
        
        infoEski=imfinfo([pathname,filename]);
        imwrite(image,filename);
        infoYeni=imfinfo(filename);
        delete(filename);
        set(handles.editBoyut,'visible', 'on');
        set(handles.editBoyut,'String',"Eski dosya boyutu:"+infoEski.FileSize+" Yeni dosya boyutu:"+infoYeni.FileSize);
        
    case 3
        axes(handles.axes3);
        imshow(compresed_image);
        axes(handles.axes4);
        imshow(compression_ratio);
    case 4
        axes(handles.axes3);
        imshow(image);
        axes(handles.axes4);
        imshow(Huffman(image));
        
        infoEski=imfinfo([pathname,filename]);
        imwrite(image,filename);
        infoYeni=imfinfo(filename);
        delete(filename);
        set(handles.editBoyut,'visible', 'on');
        set(handles.editBoyut,'String',"Eski dosya boyutu:"+infoEski.FileSize+" Yeni dosya boyutu:"+infoYeni.FileSize);

    case 5
         axes(handles.axes3);
        imshow(compresed_image);
        axes(handles.axes4);
        imshow(compression_ratio);
    otherwise
end


% --- Executes during object creation, after setting all properties.
function popupSikistirma_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in reset.
function reset_Callback(hObject, eventdata, handles)
% Burada ekran ilk açýldýðý hale gelmektedir.
cla(handles.axes2,'reset');
cla(handles.axes3,'reset');
cla(handles.axes4,'reset');
cla(handles.axes7,'reset');
cla(handles.axes8,'reset');
set(handles.axes7,'visible', 'off');
set(handles.axes8,'visible', 'off');
set(handles.noktaBazliGroup,'visible', 'off');
set(handles.filtreGroup,'visible', 'off');
set(handles.morfolojikGroup,'visible', 'off');
set(handles.sikistirmaGroup,'visible', 'off');
set(handles.editresimadi,'String', ' '); 
set(handles.editresimyolu,'String', ' ');
set(handles.txt_Genislik,'String', ' ');
set(handles.editBoyut,'String', ' ');
set(handles.txt_Yukseklik,'String', ' ');



function editBoyut_Callback(hObject, eventdata, handles)
% hObject    handle to editBoyut (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of editBoyut as text
%        str2double(get(hObject,'String')) returns contents of editBoyut as a double


% --- Executes during object creation, after setting all properties.
function editBoyut_CreateFcn(hObject, eventdata, handles)
% hObject    handle to editBoyut (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_log_Callback(hObject, eventdata, handles)
% hObject    handle to edit_log (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_log as text
%        str2double(get(hObject,'String')) returns contents of edit_log as a double


% --- Executes during object creation, after setting all properties.
function edit_log_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_log (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_gauss_Callback(hObject, eventdata, handles)
% hObject    handle to edit_gauss (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_gauss as text
%        str2double(get(hObject,'String')) returns contents of edit_gauss as a double


% --- Executes during object creation, after setting all properties.
function edit_gauss_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_gauss (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_sobel_Callback(hObject, eventdata, handles)
% hObject    handle to edit_sobel (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_sobel as text
%        str2double(get(hObject,'String')) returns contents of edit_sobel as a double


% --- Executes during object creation, after setting all properties.
function edit_sobel_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_sobel (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_prewitt_Callback(hObject, eventdata, handles)
% hObject    handle to edit_prewitt (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_prewitt as text
%        str2double(get(hObject,'String')) returns contents of edit_prewitt as a double


% --- Executes during object creation, after setting all properties.
function edit_prewitt_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_prewitt (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_laplace_Callback(hObject, eventdata, handles)
% hObject    handle to edit_laplace (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_laplace as text
%        str2double(get(hObject,'String')) returns contents of edit_laplace as a double


% --- Executes during object creation, after setting all properties.
function edit_laplace_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_laplace (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_median_Callback(hObject, eventdata, handles)
% hObject    handle to edit_median (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_median as text
%        str2double(get(hObject,'String')) returns contents of edit_median as a double


% --- Executes during object creation, after setting all properties.
function edit_median_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_median (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_mean_Callback(hObject, eventdata, handles)
% hObject    handle to edit_mean (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_mean as text
%        str2double(get(hObject,'String')) returns contents of edit_mean as a double


% --- Executes during object creation, after setting all properties.
function edit_mean_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_mean (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function editresimadi_Callback(hObject, eventdata, handles)
% hObject    handle to editresimadi (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of editresimadi as text
%        str2double(get(hObject,'String')) returns contents of editresimadi as a double


% --- Executes during object creation, after setting all properties.
function editresimadi_CreateFcn(hObject, eventdata, handles)
% hObject    handle to editresimadi (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function editresimyolu_Callback(hObject, eventdata, handles)
% hObject    handle to editresimyolu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of editresimyolu as text
%        str2double(get(hObject,'String')) returns contents of editresimyolu as a double


% --- Executes during object creation, after setting all properties.
function editresimyolu_CreateFcn(hObject, eventdata, handles)
% hObject    handle to editresimyolu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function txt_Yukseklik_Callback(hObject, eventdata, handles)
% hObject    handle to txt_Yukseklik (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of txt_Yukseklik as text
%        str2double(get(hObject,'String')) returns contents of txt_Yukseklik as a double


% --- Executes during object creation, after setting all properties.
function txt_Yukseklik_CreateFcn(hObject, eventdata, handles)
% hObject    handle to txt_Yukseklik (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function txt_Genislik_Callback(hObject, eventdata, handles)
% hObject    handle to txt_Genislik (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data s(see GUIDATA)

% Hints: get(hObject,'String') returns contents of txt_Genislik as text
%        str2double(get(hObject,'String')) returns contents of txt_Genislik as a double


% --- Executes during object creation, after setting all properties.
function txt_Genislik_CreateFcn(hObject, eventdata, handles)
% hObject    handle to txt_Genislik (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
