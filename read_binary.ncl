; NCL file created by /Applications/NCL/Grad2NCL/ctl2ncl.rb
load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/gsn_code.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/gsn_csm.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/wrf/WRFUserARW.ncl"



begin
; Longitude co-ordinate

yyear=2013

TIME = yyyymmdd_time(yyear, yyear, "integer")
NT=dimsizes(TIME)
      yyyymmdd=tostring(TIME)
      do iday=0,0
      temp=stringtochar(yyyymmdd(iday))
      yyyy=chartostring(temp(0:3))
      mm=chartostring(temp(4:5))
      dd=chartostring(temp(6:7))
      

 path="/mnt/data3_TiP/TPbigdata_zhjh/"+yyyy+"/"+mm+"/TPbigdata_"+yyyy+"-"+mm+"-"+dd+".dat"



; ................
  nlon=311
  lon=fspan(74.0,105.0,311)
  lon!0="lon"
  lon&lon=lon
  lon@units="degrees_east"
  lon@long_name="Longitude"
  printVarSummary(lon)

; Latitude co-ordinate
; ................
  nlat=131
  lat=fspan(26.5,39.5,131)
  lat!0="lat"
  lat&lat=lat
  lat@units="degrees_north"
  lat@long_name="Latitude"
  printVarSummary(lat)

; Z co-ordinate
; ................
  nlev=45
  lev=(/3000,3200,3400,3600,3800,4000,4200,4400,4600,4800,5000,5200,5400,5600,5800,6000,6200,6400,6600,6800,7000,7200,7400,7600,7800,8000,8500,9000,9500,10000,10500,11000,11500,12000,12500,13000,13500,14000,14500,15000,16000,17000,18000,19000,20000/)
  lev!0="lev"
  lev&lev=lev
  lev@units="m" ; this is for GrADs
  lev@long_name="z-levels"
  lev@original_units = "unknown ... please fill in"
  print(lev)

; T co-ordinate
; ................
  ntim=12
  time=fspan(0.5,22.5,ntim)
  time!0="time"
  time&time=time
  time@units="hours since "+tostring(yyear)+"-"+mm+"-"+dd+" 0:0"
  time@long_name="time"
  printVarSummary(time)

iymdh    = cd_calendar(time, -3)
print(iymdh)

; Open the binary data file
;  Please fill this up yourselves
;  setfileoption("bin","ReadByteOrder","endianness")
  ;path="/mnt/data3_TiP/TPbigdata_zhjh/2013/01/TPbigdata_2013-01-01.dat"
  rec_dims=(/nlat,nlon/)
  rec_type="float"

      
  tim2=time(0:ntim-1)
  ntim2=dimsizes(tim2)
  nens=1      
  ts=new( (/ntim2,nens,nlat,nlon/), rec_type )
  do it=0,ntim-1
     itt=it-0
    rec_num=it*280  
    do il=0,nens-1
   ;print(sprinti("%0.5i",rec_num))
      ts(itt,il,:,:)=fbindirread(path,rec_num,rec_dims,rec_type )
      rec_num=rec_num+1
    end do
  end do
      
  ts@units="Skin_Temperature"      
  ts@long_name="**"      
  ts!0="time"
  ts!1="lev"
  ts!2="lat"
  ts!3="lon"
  ts&lon=lon
  ts&lat=lat
  ts&lev=lev(:nens-1)
;  print(lev(:nens-1))
  ts&time=tim2
  ts@_FillValue=-999.0
  ts@missing_value=-999.0
      
      
  tim2=time(0:ntim-1)
  ntim2=dimsizes(tim2)
  nens=1      
  t2=new( (/ntim2,nens,nlat,nlon/), rec_type )
  do it=0,ntim-1
    itt=it-0
  
    rec_num=280*it+1
    do il=0,nens-1
   ;  print(sprinti("%0.5i",rec_num))
      t2(itt,il,:,:)=fbindirread(path,rec_num,rec_dims,rec_type )
      rec_num=rec_num+1
    end do
  end do
      
  t2@units="2M_Temperature"      
  t2@long_name="**"      
  t2!0="time"
  t2!1="lev"
  t2!2="lat"
  t2!3="lon"
  t2&lon=lon
  t2&lat=lat
  t2&lev=lev(:nens-1)
 ; print(lev(:nens-1))
  t2&time=tim2
  t2@_FillValue=-999.0
  t2@missing_value=-999.0
      
      
  tim2=time(0:ntim-1)
  ntim2=dimsizes(tim2)
  nens=1     
  q2=new( (/ntim2,nens,nlat,nlon/), rec_type )
  do it=0,ntim-1
    itt=it-0
rec_num=280*it+2
    do il=0,nens-1
    ;  print(sprinti("%0.5i",rec_num))
      q2(itt,il,:,:)=fbindirread(path,rec_num,rec_dims,rec_type )
      rec_num=rec_num+1
    end do
  end do
      
  q2@units="2M_Specific_Humidity"      
  q2@long_name="**"      
  q2!0="time"
  q2!1="lev"
  q2!2="lat"
  q2!3="lon"
  q2&lon=lon
  q2&lat=lat
  q2&lev=lev(:nens-1)
  ;print(lev(:nens-1))
  q2&time=tim2
  q2@_FillValue=-999.0
  q2@missing_value=-999.0
      
      
  tim2=time(0:ntim-1)
  ntim2=dimsizes(tim2)
  nens=1     
  dlr=new( (/ntim2,nens,nlat,nlon/), rec_type )
  do it=0,ntim-1
    itt=it-0
rec_num=280*it+3
    do il=0,nens-1
    ;print(sprinti("%0.5i",rec_num))
      dlr(itt,il,:,:)=fbindirread(path,rec_num,rec_dims,rec_type )
      rec_num=rec_num+1
    end do
  end do
      
  dlr@units="Downward_Longwave_Radiation"      
  dlr@long_name="**"      
  dlr!0="time"
  dlr!1="lev"
  dlr!2="lat"
  dlr!3="lon"
  dlr&lon=lon
  dlr&lat=lat
  dlr&lev=lev(:nens-1)
 ; print(lev(:nens-1))
  dlr&time=tim2
  dlr@_FillValue=-999.0
  dlr@missing_value=-999.0
      
      
  tim2=time(0:ntim-1)
  ntim2=dimsizes(tim2)
  nens=1      
  ulr=new( (/ntim2,nens,nlat,nlon/), rec_type )
  do it=0,ntim-1
    itt=it-0
  rec_num=280*it+4
    do il=0,nens-1
   ; print(sprinti("%0.5i",rec_num))
      ulr(itt,il,:,:)=fbindirread(path,rec_num,rec_dims,rec_type )
      rec_num=rec_num+1
    end do
  end do
      
  ulr@units="Upward_Longwave_Radiation"      
  ulr@long_name="**"      
  ulr!0="time"
  ulr!1="lev"
  ulr!2="lat"
  ulr!3="lon"
  ulr&lon=lon
  ulr&lat=lat
  ulr&lev=lev(:nens-1)
  ;print(lev(:nens-1))
  ulr&time=tim2
  ulr@_FillValue=-999.0
  ulr@missing_value=-999.0
      
      
  tim2=time(0:ntim-1)
  ntim2=dimsizes(tim2)
  nens=1     
  dr=new( (/ntim2,nens,nlat,nlon/), rec_type )
  do it=0,ntim-1
    itt=it-0
rec_num=280*it+5
    do il=0,nens-1
  ; print(sprinti("%0.5i",rec_num))
      dr(itt,il,:,:)=fbindirread(path,rec_num,rec_dims,rec_type )
      rec_num=rec_num+1
    end do
  end do
      
  dr@units="Downward_Shortwave_Radiation"      
  dr@long_name="**"      
  dr!0="time"
  dr!1="lev"
  dr!2="lat"
  dr!3="lon"
  dr&lon=lon
  dr&lat=lat
  dr&lev=lev(:nens-1)
  ;print(lev(:nens-1))
  dr&time=tim2
  dr@_FillValue=-999.0
  dr@missing_value=-999.0
      
      
  tim2=time(0:ntim-1)
  ntim2=dimsizes(tim2)
  nens=1      
  ur=new( (/ntim2,nens,nlat,nlon/), rec_type )
  do it=0,ntim-1
    itt=it-0
rec_num=280*it+6
    do il=0,nens-1
     ; print(sprinti("%0.5i",rec_num))
      ur(itt,il,:,:)=fbindirread(path,rec_num,rec_dims,rec_type )
      rec_num=rec_num+1
    end do
  end do
      
  ur@units="Upward_Shortwave_Radiation"      
  ur@long_name="**"      
  ur!0="time"
  ur!1="lev"
  ur!2="lat"
  ur!3="lon"
  ur&lon=lon
  ur&lat=lat
  ur&lev=lev(:nens-1)
  ;print(lev(:nens-1))
  ur&time=tim2
  ur@_FillValue=-999.0
  ur@missing_value=-999.0
      
      
  tim2=time(0:ntim-1)
  ntim2=dimsizes(tim2)
  nens=1     
  hs=new( (/ntim2,nens,nlat,nlon/), rec_type )
  do it=0,ntim-1
    itt=it-0
rec_num=280*it+7
    do il=0,nens-1
     ;print(sprinti("%0.5i",rec_num))
      hs(itt,il,:,:)=fbindirread(path,rec_num,rec_dims,rec_type )
      rec_num=rec_num+1
    end do
  end do
      
  hs@units="Sensible_Heat_Flux"      
  hs@long_name="**"      
  hs!0="time"
  hs!1="lev"
  hs!2="lat"
  hs!3="lon"
  hs&lon=lon
  hs&lat=lat
  hs&lev=lev(:nens-1)
  ;print(lev(:nens-1))
  hs&time=tim2
  hs@_FillValue=-999.0
  hs@missing_value=-999.0
      
      
  tim2=time(0:ntim-1)
  ntim2=dimsizes(tim2)
  nens=1      
  le=new( (/ntim2,nens,nlat,nlon/), rec_type )
  do it=0,ntim-1
    itt=it-0
rec_num=280*it+8
    do il=0,nens-1
     ;print(sprinti("%0.5i",rec_num))
      le(itt,il,:,:)=fbindirread(path,rec_num,rec_dims,rec_type )
      rec_num=rec_num+1
    end do
  end do
      
  le@units="Latent_Heat_Flux"      
  le@long_name="**"      
  le!0="time"
  le!1="lev"
  le!2="lat"
  le!3="lon"
  le&lon=lon
  le&lat=lat
  le&lev=lev(:nens-1)
  ;print(lev(:nens-1))
  le&time=tim2
  le@_FillValue=-999.0
  le@missing_value=-999.0
      
      
  tim2=time(0:ntim-1)
  ntim2=dimsizes(tim2)
   nens=1      
  sp=new( (/ntim2,nens,nlat,nlon/), rec_type )
  do it=0,ntim-1
    itt=it-0
rec_num=280*it+9
    do il=0,nens-1
     ; print(sprinti("%0.5i",rec_num))
      sp(itt,il,:,:)=fbindirread(path,rec_num,rec_dims,rec_type )
      rec_num=rec_num+1
    end do
  end do
      
  sp@units="Surface_Pressure"      
  sp@long_name="**"      
  sp!0="time"
  sp!1="lev"
  sp!2="lat"
  sp!3="lon"
  sp&lon=lon
  sp&lat=lat
  sp&lev=lev(:nens-1)
  ;print(lev(:nens-1))
  sp&time=tim2
  sp@_FillValue=-999.0
  sp@missing_value=-999.0
      
      
  tim2=time(0:ntim-1)
  ntim2=dimsizes(tim2)
  nens=45      
  pr=new( (/ntim2,nens,nlat,nlon/), rec_type )
  do it=0,ntim-1
    itt=it-0
rec_num=280*it+10
    do il=0,nens-1
    ; print(sprinti("%0.5i",rec_num))
      pr(itt,il,:,:)=fbindirread(path,rec_num,rec_dims,rec_type )
      rec_num=rec_num+1
    end do
  end do
     ; print(lev)
  pr@units="Pressure"      
  pr@long_name="**"      
  pr!0="time"
  pr!1="lev"
  pr!2="lat"
  pr!3="lon"
  pr&lon=lon
  pr&lat=lat
  pr&lev=lev(:nens-1)
  ;print(lev(:nens-1))
  pr&time=tim2
  pr@_FillValue=-999.0
  pr@missing_value=-999.0
      
      
  tim2=time(0:ntim-1)
  ntim2=dimsizes(tim2)
  nens=45      
  te=new( (/ntim2,nens,nlat,nlon/), rec_type )
  do it=0,ntim-1
    itt=it-0
rec_num=280*it+10+45
    do il=0,nens-1
    ; print(sprinti("%0.5i",rec_num))
      te(itt,il,:,:)=fbindirread(path,rec_num,rec_dims,rec_type )
      rec_num=rec_num+1
    end do
  end do
      
  te@units="Temperature"      
  te@long_name="**"      
  te!0="time"
  te!1="lev"
  te!2="lat"
  te!3="lon"
  te&lon=lon
  te&lat=lat
  te&lev=lev(:nens-1)
  ;print(lev(:nens-1))
  te&time=tim2
  te@_FillValue=-999.0
  te@missing_value=-999.0
      
      
  tim2=time(0:ntim-1)
  ntim2=dimsizes(tim2)
  nens=45      
  qv=new( (/ntim2,nens,nlat,nlon/), rec_type )
  do it=0,ntim-1
    itt=it-0
rec_num=280*it+10+2*45
    do il=0,nens-1
      ;print(sprinti("%0.5i",rec_num))
      qv(itt,il,:,:)=fbindirread(path,rec_num,rec_dims,rec_type )
      rec_num=rec_num+1
    end do
  end do
      
  qv@units="Specific_Humidity"      
  qv@long_name="**"      
  qv!0="time"
  qv!1="lev"
  qv!2="lat"
  qv!3="lon"
  qv&lon=lon
  qv&lat=lat
  qv&lev=lev(:nens-1)
  ;print(lev(:nens-1))
  qv&time=tim2
  qv@_FillValue=-999.0
  qv@missing_value=-999.0
      
      
  tim2=time(0:ntim-1)
  ntim2=dimsizes(tim2)
  nens=45      
  uu=new( (/ntim2,nens,nlat,nlon/), rec_type )
  do it=0,ntim-1
    itt=it-0
 rec_num=280*it+10+3*45
    do il=0,nens-1
      ; print(sprinti("%0.5i",rec_num))
      uu(itt,il,:,:)=fbindirread(path,rec_num,rec_dims,rec_type )
      rec_num=rec_num+1
    end do
  end do
      
  uu@units="Zonal_Wind"      
  uu@long_name="**"      
  uu!0="time"
  uu!1="lev"
  uu!2="lat"
  uu!3="lon"
  uu&lon=lon
  uu&lat=lat
  uu&lev=lev(:nens-1)
  ;print(lev(:nens-1))
  uu&time=tim2
  uu@_FillValue=-999.0
  uu@missing_value=-999.0
      
      
  tim2=time(0:ntim-1)
  ntim2=dimsizes(tim2)
  nens=45      
  vv=new( (/ntim2,nens,nlat,nlon/), rec_type )
  do it=0,ntim-1
    itt=it-0
rec_num=280*it+10+4*45
    do il=0,nens-1
     ;  print(sprinti("%0.5i",rec_num))
      vv(itt,il,:,:)=fbindirread(path,rec_num,rec_dims,rec_type )
      rec_num=rec_num+1
    end do
  end do
      
  vv@units="Meridional_Wind"      
  vv@long_name="**"      
  vv!0="time"
  vv!1="lev"
  vv!2="lat"
  vv!3="lon"
  vv&lon=lon
  vv&lat=lat
  vv&lev=lev(:nens-1)
  ;print(lev(:nens-1))
  vv&time=tim2
  vv@_FillValue=-999.0
  vv@missing_value=-999.0
      
      
  tim2=time(0:ntim-1)
  ntim2=dimsizes(tim2)
  nens=45      
  ww=new( (/ntim2,nens,nlat,nlon/), rec_type )
  do it=0,ntim-1
    itt=it-0
rec_num=280*it+10+5*45
    do il=0,nens-1
     ; print(sprinti("%0.5i",rec_num))
      ww(itt,il,:,:)=fbindirread(path,rec_num,rec_dims,rec_type )
      rec_num=rec_num+1
    end do
  end do
      
  ww@units="Vertical_Velocity"      
  ww@long_name="**"      
  ww!0="time"
  ww!1="lev"
  ww!2="lat"
  ww!3="lon"
  ww&lon=lon
  ww&lat=lat
  ww&lev=lev(:nens-1)
  ;print(lev(:nens-1))
  ww&time=tim2
  ww@_FillValue=-999.0
  ww@missing_value=-999.0
      
  delete([/temp,yyyy,mm,dd/])    
      end do
      
      
      
; Write out as a NetCDF file 
if (fileexists("test_ctl.nc")) then
system("/bin/rm -f test_ctl.nc") 
end if
fout=addfile("test_ctl.nc","c") 
fout->ts=ts(:,0,:,:)  ;0-11    0   280
fout->t2=t2(:,0,:,:)  ;12-     1
fout->q2=q2(:,0,:,:)  ;12*2      2
fout->dlr=dlr(:,0,:,:)  ;12*3    3
fout->ulr=ulr(:,0,:,:) ;12*4   
fout->dr=dr(:,0,:,:)   ;12*5
fout->ur=ur(:,0,:,:)   ; 12*6
fout->hs=hs(:,0,:,:)   ;12*7
fout->le=le(:,0,:,:)  ;12*8
fout->sp=sp(:,0,:,:) ;12*9
fout->pr=pr        ;12*10    10  54  .. 290  334
fout->te=te        ;12*10+12*45    55  99 ..  335  379
fout->qv=qv        ;12*10+2*12*45   100 144 .. 
fout->uu=uu        ;12*10+3*12*45   145  189..
fout->vv=vv        ;12*10+4*12*45   190 234..
fout->ww=ww        ;12*10+5*12*45=120+2700    235 279..
                  ;3240

;printVarSummary(ts)
 wks = gsn_open_wks("png", "test_ctl")
plot=new(3,graphic)
res               = True
res@gsnDraw      =  False                   ; do not draw the plot
  res@gsnFrame     =  False                   ; do not advance the frame


  res@cnLineLabelsOn       = False            ; do not use line labels
  res@cnFillOn             = True             ; color fill
  res@cnLinesOn=False
  
  res@cnFillOn      = True  
  res@cnFillPalette = "rainbow"
 res@gsnLeftString=""

res@cnInfoLabelOn       = False


  res@gsnAddCyclic      = False
 res@mpLimitMode            = "LatLon"          ; choose region of map
  res@mpMinLatF       = 25
  res@mpMaxLatF      = 40
  res@mpMinLonF       = 75
  
  res@mpMaxLonF      = 105

; The following 4 pieces of information are REQUIRED to properly display
; data on a native lambert conformal grid.  This data should be specified
; somewhere in the model itself, but in this case, it was not.
  
  res@mpProjection           = "LambertConformal"
  res@mpLambertParallel1F    = 20.0
  res@mpLambertParallel2F    = 50.0
  res@mpLambertMeridianF     = 90.0

;---Zoom in on plot

  res@mpGridAndLimbOn        = True
  res@pmTickMarkDisplayMode  = "Always"           ; turn on tickmarks
  
  res@mpGridLineDashPattern  = 5                  ; lat/lon lines dashed
  res@mpGridLatSpacingF      = 7.5
  res@mpGridLonSpacingF      = 45
  res@mpGridAndLimbDrawOrder = "PostDraw"          ; Draw grid first

 res@mpDataSetName = "Earth..4"
res@mpDataBaseVersion = "MediumRes"
res@mpOutlineSpecifiers        = (/"China:states","China:Provinces"/)
res@mpCountyLineColor = (/"Blue"/)
res@mpCountyLineThicknessF = 2.
res@mpNationalLineColor= (/"black"/)
res@mpNationalLineThicknessF = 3.
res@mpGeophysicalLineColor= (/"black"/)
res@mpGeophysicalLineThicknessF = 3.
res@mpOutlineBoundarySets="NoBoundaries"
  res@gsnRightString="Unit: K"
  res@gsnCenterString="TS"
res@lbOrientation        = "Vertical"   ; vertical label bar
res@lbLabelBarOn        = True




  res@cnLevelSelectionMode = "ManualLevels"
  res@cnMinLevelValF       = -20.0
  res@cnMaxLevelValF       =30.0
  res@cnLevelSpacingF      = 2.0


  plot(0) = gsn_csm_contour_map(wks,uu(8,3,:,:),res)
  
  
  
 



plot(1)=gsn_csm_contour_map(wks,uu(9,3,:,:),res)

plot(2)=gsn_csm_contour_map(wks,uu(10,3,:,:),res)

  resP                  = True                   ; modify the panel plot

  resP@gsnPanelFigureStrings= (/"a)","b)","c)"/) ; add strings to panel
  resP@amJust   = "TopLeft"
  gsn_panel(wks,plot,(/3,1/),resP)               ; now draw as one plot




end