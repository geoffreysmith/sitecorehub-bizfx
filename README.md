# sitecorehub-bizfx
*Sitecore 9.2 XC*

## BizFX 9.2 Installation Instructions

## Files Needed

> Remove ^M Windows style endings in Sublime by going to View > Line Endings > Unix
```sh
#!/bin/sh
# extract.sh
for f in $(unzip -l "Sitecore.Commerce.WDP.2019.07-4.0.165.zip"); do
       if [ $f = "Sitecore.BizFX.SDK.3.0.7.zip" ]
       then
           unzip -q -d . Sitecore.Commerce.WDP.2019.07-4.0.165.zip $f
           unzip -q -d . $f
           rm $f
       fi
       if [ $f = "speak-ng-bcl-0.8.0.tgz" ]
       then
           unzip -q -d . Sitecore.Commerce.WDP.2019.07-4.0.165.zip $f
       fi
       if [ $f = "speak-styling-0.9.0-r00078.tgz" ]
       then
           unzip -q -d . Sitecore.Commerce.WDP.2019.07-4.0.165.zip $f
       fi
done;
rm "Sitecore.Commerce.WDP.2019.07-4.0.165.zip"```