#Aqueduct - Compliance Remediation Content
#Copyright (C) 2011,2012  Vincent C. Passaro (vincent.passaro@gmail.com)
#
#This program is free software; you can redistribute it and/or
#modify it under the terms of the GNU General Public License
#as published by the Free Software Foundation; either version 2
#of the License, or (at your option) any later version.
#
#This program is distributed in the hope that it will be useful,
#but WITHOUT ANY WARRANTY; without even the implied warranty of
#MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#GNU General Public License for more details.
#
#You should have received a copy of the GNU General Public License
#along with this program; if not, write to the Free Software
#Foundation, Inc., 51 Franklin Street, Fifth Floor,
#Boston, MA  02110-1301, USA.

#!/bin/bash
######################################################################
#By Tummy a.k.a Vincent C. Passaro		                     #
#Vincent[.]Passaro[@]gmail[.]com				     #
#www.vincentpassaro.com						     #
######################################################################
#_____________________________________________________________________
#|  Version |   Change Information  |      Author        |    Date    |
#|__________|_______________________|____________________|____________|
#|    1.0   |   Initial Script      | Vincent C. Passaro | 20-oct-2011|
#|	    |   Creation	    |                    |            |
#|__________|_______________________|____________________|____________|
#
#
#  - Updated by Shannon Mitchell(shannon.mitchell@fusiontechnology-llc.com)
# on 05-Feb-2012 to include an ACL check before running setfacl.


#######################DISA INFORMATION###############################
#Group ID (Vulid): V-22445
#Group Title: The ftpusers file extended permissions
#Rule ID: SV-26705r1_rule
#Severity: CAT II
#Rule Version (STIG-ID): GEN004950
#Rule Title: The ftpusers file must not have an extended ACL.
#
#Vulnerability Discussion: Excessive permissions on the ftpusers file could permit unauthorized modification. Unauthorized modification could result in denial of service to authorized FTP users or permit unauthorized users to access the FTP service.
#
#Responsibility: System Administrator
#IAControls: ECLP-1
#
#Check Content: 
#Check the permissions of the /etc/ftpusers file.
# ls -lL /etc/ftpusers /etc/vsftpd.ftpusers /etc/vsftpd/ftpusers
#If the permissions include a '+', the file has an extended ACL, this is a finding.
#
#Fix Text: Remove the extended ACL from the file.
# setfacl --remove-all /etc/ftpusers /etc/vsftpd.ftpusers /etc/vsftpd/ftpusers    
#######################DISA INFORMATION###############################

#Global Variables#
PDI=GEN004950

#Start-Lockdown

for FTPFILE in /etc/ftpusers /etc/vsftpd.ftpusers /etc/vsftpd/ftpusers
do

  if [ -a "$FTPFILE" ]
  then
    ACLOUT=`getfacl --skip-base $FTPFILE 2>/dev/null`;
    if [ "$ACLOUT" != "" ]
    then
      setfacl --remove-all $FTPFILE
    fi
  fi

done
