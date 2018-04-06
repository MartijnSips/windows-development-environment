Import-Module "c:\\users\\vagrant\\scripts\\Set-RvShortcutToRunAsAdministrator.psm1"

Write-Host "- PostgreSQL + PGAdmin4 ..."
choco install postgresql -y
choco install pgadmin4 -y
Invoke-Expression "c:\users\vagrant\scripts\taskbarpin.vbs 'C:\Program Files (x86)\pgAdmin 4\v2\runtime\pgAdmin4.exe'"

Write-Host "- Eclipse and its plugins ..."
choco install eclipse -y
$eclipsedir=(gci "C:\Program Files\eclipse*" | ? { $_.PSIsContainer } | sort CreationTime)[-1].Name
Invoke-Expression "& 'C:\Program Files\${eclipsedir}\eclipse\eclipse.exe' -nosplash -application org.eclipse.equinox.p2.director -repository http://cucumber.github.io/cucumber-eclipse/update-site -installIUs cucumber.eclipse.feature.feature.group"
Invoke-Expression "& 'C:\Program Files\v\eclipse\eclipse.exe' -nosplash -application org.eclipse.equinox.p2.director -repository https://otto.takari.io/content/sites/m2e.extras/m2eclipse-mavenarchiver/0.17.2/N/LATEST/ -installIUs org.sonatype.m2e.mavenarchiver.feature.feature.group"
Invoke-Expression "& 'C:\Program Files\${eclipsedir}\eclipse\eclipse.exe' -nosplash -application org.eclipse.equinox.p2.director -repository http://eclipse-cs.sourceforge.net/update -installIUs net.sf.eclipsecs.feature.group"
Invoke-Expression "& 'C:\Program Files\${eclipsedir}\eclipse\eclipse.exe' -nosplash -application org.eclipse.equinox.p2.director -repository http://findbugs.cs.umd.edu/eclipse -installIUs edu.umd.cs.findbugs.plugin.eclipse.feature.group"
Invoke-Expression "& 'C:\Program Files\${eclipsedir}\eclipse\eclipse.exe' -nosplash -application org.eclipse.equinox.p2.director -repository http://www.sonarlint.org/eclipse -installIUs org.sonarlint.eclipse.feature.feature.group"
Invoke-Expression "& 'C:\Program Files\${eclipsedir}\eclipse\eclipse.exe' -nosplash -application org.eclipse.equinox.p2.director -repository http://coderplus.com/m2e-update-sites/jaxws-maven-plugin -installIUs com.coderplus.m2e.jaxwscore"
Invoke-Expression "& 'C:\Program Files\${eclipsedir}\eclipse\eclipse.exe' -nosplash -application org.eclipse.equinox.p2.director -repository https://repository.sonatype.org/content/repositories/forge-sites/m2e-extras/0.15.0/N/0.15.0.201206251206 -installIUs org.sonatype.m2e.buildhelper"
Invoke-Expression "& 'C:\Program Files\${eclipsedir}\eclipse\eclipse.exe' -nosplash -application org.eclipse.equinox.p2.director -repository http://www.mihai-nita.net/eclipse -installIUs net.mihai-nita.ansicon.feature.group"
Invoke-Expression "& 'C:\Program Files\${eclipsedir}\eclipse\eclipse.exe' -nosplash -application org.eclipse.equinox.p2.director -repository http://www.genuitec.com/updates/webclipse/oxygen -installIUs com.genuitec.eclipse.theming.feature.feature.group"
# Angular IDE plugin
Invoke-Expression "& 'C:\Program Files\${eclipsedir}\eclipse\eclipse.exe' -nosplash -application org.eclipse.equinox.p2.director -repository https://www.genuitec.com/updates/webclipse/ci -installIUs com.genuitec.eclipse.angularide.feature.feature.group"
# LESS Plugin
Invoke-Expression "& 'C:\Program Files\${eclipsedir}\eclipse\eclipse.exe' -nosplash -application org.eclipse.equinox.p2.director -repository http://www.normalesup.org/~simonet/soft/ow/update -installIUs net.vtst.ow.eclipse.less.feature.feature.group"
# PHP Development Tools
Invoke-Expression "& 'C:\Program Files\${eclipsedir}\eclipse\eclipse.exe' -nosplash -application org.eclipse.equinox.p2.director -repository http://download.eclipse.org/tools/pdt/updates/5.2 -installIUs org.eclipse.php.feature.group"
# PHP Symphony
Invoke-Expression "& 'C:\Program Files\${eclipsedir}\eclipse\eclipse.exe' -nosplash -application org.eclipse.equinox.p2.director -repository http://p2.pdt-extensions.org -installIUs com.dubture.symfony.feature.feature.group"
# PHP restful
Invoke-Expression "& 'C:\Program Files\${eclipsedir}\eclipse\eclipse.exe' -nosplash -application org.eclipse.equinox.p2.director -repository http://p2.pdt-extensions.org -installIUs org.oneclicklabs.php.restful.feature.group"
Invoke-Expression "c:\users\vagrant\scripts\taskbarpin.vbs 'C:\Program Files\${eclipsedir}\eclipse\eclipse.exe'"

choco install maven -y
choco install gow -y
choco install intellijidea-community -y
