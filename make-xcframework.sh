#!/bin/sh

#set -x # Debug
set -e # Exit on error

moduleName="GLTFKit2"

outputDirectory="$(pwd;)/$moduleName.xcframework"

archiveDirectoryName="archives"
archiveDirectory="$(pwd;)/$archiveDirectoryName"
rm -rf $archiveDirectory
rm -rf $outputDirectory

xcodebuild archive -scheme $moduleName -archivePath "$archiveDirectory/iOS/$moduleName" \
                   -destination "generic/platform=iOS" SKIP_INSTALL=NO  BUILD_LIBRARY_FOR_DISTRIBUTION=YES
xcodebuild archive -scheme $moduleName -archivePath "$archiveDirectory/iOS_Simulator/$moduleName" \
                   -destination "generic/platform=iOS Simulator" SKIP_INSTALL=NO  BUILD_LIBRARY_FOR_DISTRIBUTION=YES

xcodebuild -create-xcframework \
    -archive "$archiveDirectory/iOS/$moduleName.xcarchive" -framework $moduleName.framework \
    -archive "$archiveDirectory/iOS_Simulator/$moduleName.xcarchive" -framework $moduleName.framework \
     -output $outputDirectory

rm -rf $archiveDirectory

ditto -c -k --sequesterRsrc --keepParent GLTFKit2.xcframework GLTFKit2.xcframework.zip

swift package compute-checksum GLTFKit2.xcframework.zip
