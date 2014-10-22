JenkinsCI-iOS
=============

A Jenkins job setup.


## Installing Jenkins

Download Jenkins from here: http://jenkins-ci.org/content/thank-you-downloading-os-x-installer <br/>
I would recommend that the install should be made under the administrator user and not let the Jenkins installer create it's own user. That will generate issues when trying to access the keychain.

To run Jenkins go to `/Applications/Jenkins` and run the `jenkins.war` file. Make sure you have the latest Java JDK installed.

After that, you can access the Jenkins Dashboard using the following URL: [http://localhost:8080](http://localhost:8080)

## XCode project setup

First, go to your project target from the left top corner of XCode, click on the target and select "Manage Schemes".
There you should check the "Shared" option for your XCode project (do not check shared for the Pods project).<br/>
Target - > Manage schemes - > Check “Shared”

Then, in the project's Build Settings turn on Generate Test Coverage Files and Instrument Program Flow for the Debug configuration on your main target and for both Debug an Release for your test target.

To take advantage of the generated files you need to set the Build Products and Intermediates to be saved in a folder relative to the Workspace. You can do this by accessing XCode Preferences -> Locations -> Custom -> Relative to Workspace.


To check if everything it's OK you can build the project and check the following folders for .gcno and .gcda files
`Build/Intermediates/YOUR-TEST-TARGET-NAME.build/Objects-normal/i386'`
and
`Build/Intermediates/YOUR-MAIN-TARGET-NAME.build/Objects-normal/i386'`
You can find these based on the setting you have in Xcode for Locations.

## Jenkins plugins
To setup you job, you will need the following plugins:

XCode plugin<br />
Git plugin<br />
Keychains and Provisioning Profiles Plugin<br />
Duplicate Code Scanner Plug-in<br />
Cobertura plugin<br />
SLOCCount Plugin<br />
EnvInject Plugin<br />

To add Jenkins plugins you must go to Jenkins -> Manage Jenkins -> Manage plugins.

## Installing code metrics tools
##### Install Homebrew
To install Homebrew, simply copy-paste this code into your Terminal and press enter:

<code>ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)" </code>

##### Installing sloccount:<br/>`brew install sloccount`

##### Installing xctool:<br/>`brew install xctool`

##### Installing pmd:<br/>
You can download 4.3 from [here](http://sourceforge.net/projects/pmd/files/pmd/4.3/pmd-bin-4.3.zip/download). The latest versions have suffered major changes that aren't supported by the ObjectiveC language definition yet.<br/>
To be able to make use of PMD you will also need to dowload the PMD Objective-C language definition from [here](https://github.com/jkennedy1980/Objective-C-CPD-Language/blob/master/releases/ObjCLanguage-0.0.7-SNAPSHOT.jar) - courtesy of Josh Kennedy.


##### Installing gcovr:
```
cd ~
git clone https://github.com/gcovr/gcovr.git
sudo cp ./gcovr/scripts/gcovr /usr/local/bin
sudo chown root:wheel /usr/local/bin/gcovr
sudo chmod 755 /usr/local/bin/gcovr
cd ~
rm -rf ./gcovr/
```


## Setting up the job

Here comes the fun part: setting up the Jenkins job.
The first step is creating the job: New item -> Freestyle project. This will let you do all the configuration of a job.

#### Source Code Management
Our project is usually stored in a Git or SVN repository. The Jenkins job begins with this step: cloning the latest version of your branch.
You can setup this by adding your repository info & credentials in the Source Code Management section. For our job, we have a GitHub repostiory: https://github.com/cyupa/JenkinsCI-iOS.git and your GitHub credentials. Then you can specify the branch you want to clone and build, in this case: `*/master`.

#### Build Environment
A Jenkins job does not have access to environment variables such as PATH, that allows us the invoke different scripts and tools without specifing the full path to that script. This scripts are stored at different locations and this variable knows about those locations.

You can check the PATH variableby opening a Terminal window and type `echo $PATH`.<br />
In my case: `/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin:/Applications/Server.app/Contents/ServerRoot/usr/bin:/Applications/Server.app/Contents/ServerRoot/usr/sbin:/usr/local/Cellar/`

Next, in the Build Environment section, we will add the line `PATH=/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin:/Applications/Server.app/Contents/ServerRoot/usr/bin:/Applications/Server.app/Contents/ServerRoot/usr/sbin:/usr/local/Cellar/` in the Properties Content field.

#### Running tests

Before we go on, we should run our unit tests on our project, to make sure everything is OK.
Add a new Execute Shell build step with the following code:
```
xctool -workspace ${WORKSPACE}/JenkinsCI.xcworkspace \
       -scheme JenkinsCI \
       -reporter plain \
       -sdk iphonesimulator \
       -reporter junit:test-reports/ios-report.xml \
       test \
       -resetSimulator \
       -freshInstall
```
After this, add a Publish JUnit test results post build action to view the results of your test in your Dashboard.

At this point you can take a step back and try to build the project to check if everything is ok.

#### 


## Troubleshooting
If you encounter issues when running <code>'brew install sloccount'</code> such as:
`looking for OpenSSL headers 'openssl/md5.h'... Cannot find it.
Please run this script as such: SSLINCPATH=<path/to/ssl/include> ./configure`

Install OpenSSL via Homebrew (<code>'brew install openssl'</code>) and retry.<br/>
If that doesn't work, go to /Library/Caches/Homebrew/, unpack the md5sha1sum archive, open it, and run the following command in the Terminal: <code>SSLINCPATH=/usr/local/Cellar/openssl/1.0.1i/include ./configure</code>.

