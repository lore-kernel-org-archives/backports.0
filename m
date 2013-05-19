Return-path: <backports-owner@vger.kernel.org>
Received: from mail-pd0-f179.google.com ([209.85.192.179]:56532 "EHLO
	mail-pd0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753740Ab3ESCdw (ORCPT
	<rfc822;backports@vger.kernel.org>); Sat, 18 May 2013 22:33:52 -0400
Received: by mail-pd0-f179.google.com with SMTP id q10so4408371pdj.38
        for <backports@vger.kernel.org>; Sat, 18 May 2013 19:33:52 -0700 (PDT)
From: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>
To: backports@vger.kernel.org
Cc: mricon@kernel.org, "Luis R. Rodriguez" <mcgrof@do-not-panic.com>
Subject: [PATCH 0/8] rel-html: one fix and update for project renames
Date: Sat, 18 May 2013 19:33:34 -0700
Message-Id: <1368930822-13641-1-git-send-email-mcgrof@do-not-panic.com> (sfid-20130519_043354_018979_9DED848B)
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

From: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>

rel-html [0] is used to generate the HTML5 release pages
for the backports project but given the input received it
was designed to support any project. The backports project
was renamed and the release structure was updated as well.
This series addresse the project rename and adds support
for multiple daily snapshot releases styles. While at it
update the other projects this supports making releases
for and kick out new pages for them as examples [1].

Note the TODO from Readme.md:

 * Figure out how to automatically determine releases                           
   from git.                                                                    
                                                                                
        - If we have many stable releases how should                            
          we annotate this via git ?                                            
                                                                                
   It seems that the way to go is to require a config file                      
   for the project with the oldest stable release supported                     
   and then annotate eols. We do this right now, so rel-html                    
   would just need to be modified to infer newer releases.                      
                                                                                
 * The Linux kernel now (as of 2013-03-10) has json file for                    
   releases:                                                                    
                                                                                
        https://www.kernel.org/releases.json                                    
                                                                                
  We need to do a few things then:                                              
                                                                                
        - Get other projects to use json for releases                           
        - Add json intepreter support to rel-html                               
                                                                                
  If projects don't use json releases files as the Linux                        
  kernel does then the current usage of HTMLParser would                        
  allow us to parse / infer releases for us.                                    
                                                                                
 * See if we can copy the EOL release into an eol/ directory                    
   and moving forward instead of parsing the tags use the                       
   directory name to automatically determine other release                      
   attributes. This is only relevant for the Linux kernel                       
   right now.  

[0] git://git.kernel.org/pub/scm/linux/kernel/git/mcgrof/rel-html.git
[1] http://drvbp1.linux-foundation.org/~mcgrof/rel-html/backports/

Luis R. Rodriguez (8):
  rel_html: add support for project aliases
  rel-html: rename compat-drivers.cfg to backports.cfg
  rel-html: really listen to ignore_changelogs
  rel-html: add RFC3339 / short style next release types support
  rel-html: fix next release URLs
  rel-html: add v3.10 as supported for Linux
  rel-html: update iw release
  rel-html: update hostapd releases

 projects/backports.cfg      |   37 +++++++++++
 projects/compat-drivers.cfg |   34 ----------
 projects/hostapd.cfg        |    1 +
 projects/iw.cfg             |    1 +
 rel-html.cfg                |    1 +
 rel-html.py                 |  149 +++++++++++++++++++++++++++----------------
 6 files changed, 134 insertions(+), 89 deletions(-)
 create mode 100644 projects/backports.cfg
 delete mode 100644 projects/compat-drivers.cfg

-- 
1.7.10.4

