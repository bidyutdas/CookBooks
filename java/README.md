# Description
Installs a Java. Uses OpenJDK by default but supports installation of Oracle's JDK.

This cookbook also provides the java_ark LWRP which other java cookbooks can use to install java-related applications from binary packages.

The java_ark LWPR may move to its own cookbook at some point in the future as its functionality is useful for other purposes.

# Requirements
Platform

Debian, Ubuntu
CentOS, Red Hat, Fedora, Scientific, Amazon
ArchLinux
FreeBSD
Attributes
See attributes/default.rb for default values.

node["java"]["install_flavor"] - Flavor of JVM you would like installed (oracle or openjdk), default openjdk.
node['java']['java_home'] - Default location of the "$JAVA_HOME".
node['java']['tarball'] - name of the tarball to retrieve from your corporate repository default jdk1.6.0_29_i386.tar.gz
node['java']['tarball_checksum'] - checksum for the tarball, if you use a different tarball, you also need to create a new sha256 checksum
node['java']['jdk'] - version and architecture specific attributes for setting the URL on Oracle's site for the JDK, and the checksum of the .tar.gz.
Recipes
default

Include the default recipe in a run list, to get java. By default the openjdk flavor of Java is installed, but this can be changed by using the install_flavor attribute.

OpenJDK is the default because of licensing changes made upstream by Oracle. See notes on the oracle recipe below.

openjdk

This recipe installs the openjdk flavor of Java.

3 Resources/Providers
This LWRP provides an easy way to manage java applications. It uses the LWRP arkive (deliberately misspelled). It is an arkive and not an "archive" because the java_ark lwrp is not the same as a java archive or "jar". Essentially, you provide the java_ark with the URL to a tarball and the commands within the extracted result that you want symlinked to /usr/bin/

The java_ark LWPR may move to its own cookbook at some point in the future as its functionality is useful for other purposes.

By default, the extracted directory is extracted to app_root/extracted_dir_name and symlinked to app_root/default

# Actions
:install: extracts the tarball and makes necessary symlinks
:remove: removes the tarball and run update-alternatives for all symlinked bin_cmds
Attribute Parameters
url: path to tarball, .tar.gz, .bin (oracle-specific), and .zip currently supported
checksum: sha256 checksum, not used for security but avoid redownloading the archive on each chef-client run
app_home: the default for installations of this type of application, for example, /usr/lib/tomcat/default. If your application is not set to the default, it will be placed at the same level in the directory hierarchy but the directory name will be app_root/extracted_directory_name + "_alt"
app_home_mode: file mode for app_home, is an integer
bin_cmds: array of binary commands that should be symlinked to /usr/bin, examples are mvn, java, javac, etc. These cmds must be in the bin/ subdirectory of the extracted folder. Will be ignored if this java_ark is not the default
owner: owner of extracted directory, set to "root" by default
default: whether this the default installation of this package, boolean true or false
Examples

# Usage
Simply include the java recipe where ever you would like Java installed.

Changes
v1.4.0:

[COOK-858] - numerous updates: handle jdk6 and 7, switch from sun to oracle, make openjdk default, add java_ark LWRP.
[COOK-942] - FreeBSD support
[COOK-520] - ArchLinux support
License and Author
Author:: Seth Chisamore (schisamo@opscode.com) Author:: Bryan W. Berry (bryan.berry@gmail.com)

Copyright:: 2008-2012, Opscode, Inc

Licensed under the Apache License, Version 2.0 (the "License"); you may not use this file except in compliance with the License. You may obtain a copy of the License at

http://www.apache.org/licenses/LICENSE-2.0
Unless required by applicable law or agreed to in writing, software distributed under the License is distributed on an "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied. See the License for the specific language governing permissions and limitations under the License.
