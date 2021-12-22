#!/bin/sh

# This script is just all of the scripts by Microsoft thrown into 1 lol

# Uninstall Visual Studio for Mac
echo "Uninstalling Visual Studio for Mac..."

sudo rm -rf "/Applications/Visual Studio.app"
rm -rf ~/Library/Caches/VisualStudio
rm -rf ~/Library/Preferences/VisualStudio
rm -rf ~/Library/Preferences/Visual\ Studio
rm -rf ~/Library/Logs/VisualStudio
rm -rf ~/Library/VisualStudio
rm -rf ~/Library/Preferences/Xamarin/
rm -rf ~/Library/Application\ Support/VisualStudio
rm -rf ~/Library/Application\ Support/VisualStudio/7.0/LocalInstall/Addins/

# Uninstall Xamarin.Android
echo "Uninstalling Xamarin.Android..."

sudo rm -rf /Developer/MonoDroid
rm -rf ~/Library/MonoAndroid
sudo pkgutil --forget com.xamarin.android.pkg
sudo rm -rf /Library/Frameworks/Xamarin.Android.framework


# Uninstall Xamarin.iOS
echo "Uninstalling Xamarin.iOS..."

rm -rf ~/Library/MonoTouch
sudo rm -rf /Library/Frameworks/Xamarin.iOS.framework
sudo rm -rf /Developer/MonoTouch
sudo pkgutil --forget com.xamarin.monotouch.pkg
sudo pkgutil --forget com.xamarin.xamarin-ios-build-host.pkg


# Uninstall Xamarin.Mac
echo "Uninstalling Xamarin.Mac..."

sudo rm -rf /Library/Frameworks/Xamarin.Mac.framework
rm -rf ~/Library/Xamarin.Mac


# Uninstall Workbooks and Inspector
echo "Uninstalling Workbooks and Inspector..."

if [ -f "/Library/Frameworks/Xamarin.Interactive.framework/Versions/Current/uninstall" ]; then
    sudo /Library/Frameworks/Xamarin.Interactive.framework/Versions/Current/uninstall
fi


# Uninstall the Visual Studio for Mac Installer
echo "Uninstalling the Visual Studio for Mac Installer..."

rm -rf ~/Library/Caches/XamarinInstaller/
rm -rf ~/Library/Caches/VisualStudioInstaller/
rm -rf ~/Library/Logs/XamarinInstaller/
rm -rf ~/Library/Logs/VisualStudioInstaller/

# Uninstall the Xamarin Profiler
echo "Uninstalling the Xamarin Profiler..."

sudo rm -rf "/Applications/Xamarin Profiler.app"

echo "Finished Uninstalling Visual Studio."

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

# this is the common suffix for all the dotnet pkgs
dotnet_pkg_name_suffix="com.microsoft.dotnet"
dotnet_install_root="/usr/local/share/dotnet"
dotnet_path_file="/etc/paths.d/dotnet"
dotnet_tool_path_file="/etc/paths.d/dotnet-cli-tools"

remove_dotnet_pkgs(){
    installed_pkgs=($(pkgutil --pkgs | grep $dotnet_pkg_name_suffix))
    
    for i in "${installed_pkgs[@]}"
    do
        echo "Removing dotnet component - \"$i\"" >&2
        sudo pkgutil --force --forget "$i"
    done
}

remove_dotnet_pkgs
[ "$?" -ne 0 ] && echo "Failed to remove dotnet packages." >&2 && exit 1

echo "Deleting install root - $dotnet_install_root" >&2
sudo rm -rf "$dotnet_install_root"
sudo rm -f "$dotnet_path_file"
sudo rm -f "$dotnet_tool_path_file"

echo "dotnet packages removal succeeded." >&2

echo "Uninstalling left over components"
sudo rm -rf /Library/Frameworks/Mono.framework
sudo pkgutil --forget com.xamarin.mono-MDK.pkg
sudo rm -rf /etc/paths.d/mono-commands
sudo rm -rf /Developer/MonoDroid
rm -rf ~/Library/MonoAndroid
sudo pkgutil --forget com.xamarin.android.pkg
sudo rm -rf /Library/Frameworks/Xamarin.Android.framework
rm -rf ~/.android
rm -rf ~/Library/MonoTouch
sudo rm -rf /Library/Frameworks/Xamarin.iOS.framework
sudo rm -rf /Developer/MonoTouch
sudo pkgutil --forget com.xamarin.monotouch.pkg
sudo pkgutil --forget com.xamarin.xamarin-ios-build-host.pkg
sudo pkgutil --forget com.xamarin.xamarin.ios.pkg
sudo rm -rf /Library/Frameworks/Xamarin.Mac.framework
rm -rf ~/Library/Xamarin.Mac
rm -rf "~/Library/Application Support/Xamarin*"
rm -rf "/Applications/Xamarin Workbooks.app"
rm -rf "/Applications/Xamarin Inspector.app"
sudo rm -rf "/Applications/Xamarin Profiler.app"
rm -rf ~/Library/Caches/XamarinInstaller/
rm -rf ~/Library/Caches/VisualStudioInstaller/
rm -rf ~/Library/Logs/XamarinInstaller/
rm -rf ~/Library/Logs/VisualStudioInstaller/
rm -rf ~/Library/Preferences/Xamarin/
rm -rf "~/Library/Preferences/Visual Studio/"

