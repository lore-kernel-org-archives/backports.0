Return-Path: <backports-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B977C433EF
	for <backports@archiver.kernel.org>; Fri, 13 May 2022 16:06:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1382319AbiEMQGI (ORCPT <rfc822;backports@archiver.kernel.org>);
        Fri, 13 May 2022 12:06:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1381678AbiEMQGH (ORCPT
        <rfc822;backports@vger.kernel.org>); Fri, 13 May 2022 12:06:07 -0400
Received: from web.adapt-ip.com (mail.adapt-ip.com [107.194.246.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF2B5286
        for <backports@vger.kernel.org>; Fri, 13 May 2022 09:06:00 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by web.adapt-ip.com (Postfix) with ESMTP id 1D6C06E3A77;
        Fri, 13 May 2022 16:06:00 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at web.adapt-ip.com
Received: from web.adapt-ip.com ([127.0.0.1])
        by localhost (web.adapt-ip.com [127.0.0.1]) (amavisd-new, port 10026)
        with LMTP id lWkcpAR8_rCc; Fri, 13 May 2022 16:05:29 +0000 (UTC)
Received: from atlas.campbell.adapt-ip.com (c-73-162-155-239.hsd1.ca.comcast.net [73.162.155.239])
        (Authenticated sender: thomas@adapt-ip.com)
        by web.adapt-ip.com (Postfix) with ESMTPSA id 9417D6E3A75;
        Fri, 13 May 2022 16:05:25 +0000 (UTC)
From:   Thomas Pedersen <thomas@adapt-ip.com>
To:     backports <backports@vger.kernel.org>
Cc:     Hauke Mehrtens <hauke@hauke-m.de>,
        Luis Chamberlain <mcgrof@kernel.org>
Subject: [PATCH v2 02/15] Squashed 'backport/kconf/' content from commit 98bda615
Date:   Fri, 13 May 2022 09:05:10 -0700
Message-Id: <20220513160523.2944694-3-thomas@adapt-ip.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220513160523.2944694-1-thomas@adapt-ip.com>
References: <20220513160523.2944694-1-thomas@adapt-ip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <backports.vger.kernel.org>
X-Mailing-List: backports@vger.kernel.org

From: Luis Chamberlain <mcgrof@kernel.org>

git-subtree-dir: backport/kconf
git-subtree-split: 98bda6156678fbc1c0930a85950418af81c0a25f
---
 backport/kconf/.gitignore                 |   24 +
 backport/kconf/GPL-2.0                    |  359 +++++
 backport/kconf/Kbuild.include             |   73 +
 backport/kconf/Makefile                   |   62 +
 backport/kconf/README.kconfig             |   13 +
 backport/kconf/conf.c                     |  921 ++++++++++++
 backport/kconf/confdata.c                 | 1262 +++++++++++++++++
 backport/kconf/expr.c                     | 1303 +++++++++++++++++
 backport/kconf/expr.h                     |  326 +++++
 backport/kconf/internal.h                 |    9 +
 backport/kconf/kconf_id.c                 |   52 +
 backport/kconf/kconfig.Makefile           |   65 +
 backport/kconf/kconfig/.gitignore         |   16 +
 backport/kconf/lexer.l                    |  468 +++++++
 backport/kconf/list.h                     |  132 ++
 backport/kconf/lkc.h                      |  156 +++
 backport/kconf/lkc_proto.h                |   52 +
 backport/kconf/lxdialog/.gitignore        |    4 +
 backport/kconf/lxdialog/BIG.FAT.WARNING   |    4 +
 backport/kconf/lxdialog/checklist.c       |  319 +++++
 backport/kconf/lxdialog/dialog.h          |  238 ++++
 backport/kconf/lxdialog/inputbox.c        |  289 ++++
 backport/kconf/lxdialog/menubox.c         |  424 ++++++
 backport/kconf/lxdialog/textbox.c         |  395 ++++++
 backport/kconf/lxdialog/util.c            |  700 ++++++++++
 backport/kconf/lxdialog/yesno.c           |  101 ++
 backport/kconf/mconf-cfg.sh               |   52 +
 backport/kconf/mconf.c                    | 1037 ++++++++++++++
 backport/kconf/menu.c                     |  881 ++++++++++++
 backport/kconf/nconf-cfg.sh               |   50 +
 backport/kconf/nconf.c                    | 1549 +++++++++++++++++++++
 backport/kconf/nconf.gui.c                |  614 ++++++++
 backport/kconf/nconf.h                    |   83 ++
 backport/kconf/parser.y                   |  716 ++++++++++
 backport/kconf/preprocess.c               |  574 ++++++++
 backport/kconf/setlocalversion            |  118 ++
 backport/kconf/symbol.c                   | 1270 +++++++++++++++++
 backport/kconf/update-upstream-kconfig.sh |   28 +
 backport/kconf/util.c                     |  129 ++
 39 files changed, 14868 insertions(+)
 create mode 100644 backport/kconf/.gitignore
 create mode 100644 backport/kconf/GPL-2.0
 create mode 100644 backport/kconf/Kbuild.include
 create mode 100644 backport/kconf/Makefile
 create mode 100644 backport/kconf/README.kconfig
 create mode 100644 backport/kconf/conf.c
 create mode 100644 backport/kconf/confdata.c
 create mode 100644 backport/kconf/expr.c
 create mode 100644 backport/kconf/expr.h
 create mode 100644 backport/kconf/internal.h
 create mode 100644 backport/kconf/kconf_id.c
 create mode 100644 backport/kconf/kconfig.Makefile
 create mode 100644 backport/kconf/kconfig/.gitignore
 create mode 100644 backport/kconf/lexer.l
 create mode 100644 backport/kconf/list.h
 create mode 100644 backport/kconf/lkc.h
 create mode 100644 backport/kconf/lkc_proto.h
 create mode 100644 backport/kconf/lxdialog/.gitignore
 create mode 100644 backport/kconf/lxdialog/BIG.FAT.WARNING
 create mode 100644 backport/kconf/lxdialog/checklist.c
 create mode 100644 backport/kconf/lxdialog/dialog.h
 create mode 100644 backport/kconf/lxdialog/inputbox.c
 create mode 100644 backport/kconf/lxdialog/menubox.c
 create mode 100644 backport/kconf/lxdialog/textbox.c
 create mode 100644 backport/kconf/lxdialog/util.c
 create mode 100644 backport/kconf/lxdialog/yesno.c
 create mode 100755 backport/kconf/mconf-cfg.sh
 create mode 100644 backport/kconf/mconf.c
 create mode 100644 backport/kconf/menu.c
 create mode 100755 backport/kconf/nconf-cfg.sh
 create mode 100644 backport/kconf/nconf.c
 create mode 100644 backport/kconf/nconf.gui.c
 create mode 100644 backport/kconf/nconf.h
 create mode 100644 backport/kconf/parser.y
 create mode 100644 backport/kconf/preprocess.c
 create mode 100755 backport/kconf/setlocalversion
 create mode 100644 backport/kconf/symbol.c
 create mode 100755 backport/kconf/update-upstream-kconfig.sh
 create mode 100644 backport/kconf/util.c

diff --git a/backport/kconf/.gitignore b/backport/kconf/.gitignore
new file mode 100644
index 000000000000..5e7b6db65d4e
--- /dev/null
+++ b/backport/kconf/.gitignore
@@ -0,0 +1,24 @@
+#
+# Generated files
+#
+*.moc
+*.lex.c
+
+#
+# configuration programs
+#
+conf
+mconf
+nconf
+qconf
+gconf
+
+parser.tab.h
+parser.tab.c
+
+*.o
+*.o.cmd
+
+lxdialog/*.o.cmd
+lxdialog/*.o
+
diff --git a/backport/kconf/GPL-2.0 b/backport/kconf/GPL-2.0
new file mode 100644
index 000000000000..ff0812fd89cc
--- /dev/null
+++ b/backport/kconf/GPL-2.0
@@ -0,0 +1,359 @@
+Valid-License-Identifier: GPL-2.0
+Valid-License-Identifier: GPL-2.0-only
+Valid-License-Identifier: GPL-2.0+
+Valid-License-Identifier: GPL-2.0-or-later
+SPDX-URL: https://spdx.org/licenses/GPL-2.0.html
+Usage-Guide:
+  To use this license in source code, put one of the following SPDX
+  tag/value pairs into a comment according to the placement
+  guidelines in the licensing rules documentation.
+  For 'GNU General Public License (GPL) version 2 only' use:
+    SPDX-License-Identifier: GPL-2.0
+  or
+    SPDX-License-Identifier: GPL-2.0-only
+  For 'GNU General Public License (GPL) version 2 or any later version' use:
+    SPDX-License-Identifier: GPL-2.0+
+  or
+    SPDX-License-Identifier: GPL-2.0-or-later
+License-Text:
+
+		    GNU GENERAL PUBLIC LICENSE
+		       Version 2, June 1991
+
+ Copyright (C) 1989, 1991 Free Software Foundation, Inc.
+                       51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
+ Everyone is permitted to copy and distribute verbatim copies
+ of this license document, but changing it is not allowed.
+
+			    Preamble
+
+  The licenses for most software are designed to take away your
+freedom to share and change it.  By contrast, the GNU General Public
+License is intended to guarantee your freedom to share and change free
+software--to make sure the software is free for all its users.  This
+General Public License applies to most of the Free Software
+Foundation's software and to any other program whose authors commit to
+using it.  (Some other Free Software Foundation software is covered by
+the GNU Library General Public License instead.)  You can apply it to
+your programs, too.
+
+  When we speak of free software, we are referring to freedom, not
+price.  Our General Public Licenses are designed to make sure that you
+have the freedom to distribute copies of free software (and charge for
+this service if you wish), that you receive source code or can get it
+if you want it, that you can change the software or use pieces of it
+in new free programs; and that you know you can do these things.
+
+  To protect your rights, we need to make restrictions that forbid
+anyone to deny you these rights or to ask you to surrender the rights.
+These restrictions translate to certain responsibilities for you if you
+distribute copies of the software, or if you modify it.
+
+  For example, if you distribute copies of such a program, whether
+gratis or for a fee, you must give the recipients all the rights that
+you have.  You must make sure that they, too, receive or can get the
+source code.  And you must show them these terms so they know their
+rights.
+
+  We protect your rights with two steps: (1) copyright the software, and
+(2) offer you this license which gives you legal permission to copy,
+distribute and/or modify the software.
+
+  Also, for each author's protection and ours, we want to make certain
+that everyone understands that there is no warranty for this free
+software.  If the software is modified by someone else and passed on, we
+want its recipients to know that what they have is not the original, so
+that any problems introduced by others will not reflect on the original
+authors' reputations.
+
+  Finally, any free program is threatened constantly by software
+patents.  We wish to avoid the danger that redistributors of a free
+program will individually obtain patent licenses, in effect making the
+program proprietary.  To prevent this, we have made it clear that any
+patent must be licensed for everyone's free use or not licensed at all.
+
+  The precise terms and conditions for copying, distribution and
+modification follow.
+
+		    GNU GENERAL PUBLIC LICENSE
+   TERMS AND CONDITIONS FOR COPYING, DISTRIBUTION AND MODIFICATION
+
+  0. This License applies to any program or other work which contains
+a notice placed by the copyright holder saying it may be distributed
+under the terms of this General Public License.  The "Program", below,
+refers to any such program or work, and a "work based on the Program"
+means either the Program or any derivative work under copyright law:
+that is to say, a work containing the Program or a portion of it,
+either verbatim or with modifications and/or translated into another
+language.  (Hereinafter, translation is included without limitation in
+the term "modification".)  Each licensee is addressed as "you".
+
+Activities other than copying, distribution and modification are not
+covered by this License; they are outside its scope.  The act of
+running the Program is not restricted, and the output from the Program
+is covered only if its contents constitute a work based on the
+Program (independent of having been made by running the Program).
+Whether that is true depends on what the Program does.
+
+  1. You may copy and distribute verbatim copies of the Program's
+source code as you receive it, in any medium, provided that you
+conspicuously and appropriately publish on each copy an appropriate
+copyright notice and disclaimer of warranty; keep intact all the
+notices that refer to this License and to the absence of any warranty;
+and give any other recipients of the Program a copy of this License
+along with the Program.
+
+You may charge a fee for the physical act of transferring a copy, and
+you may at your option offer warranty protection in exchange for a fee.
+
+  2. You may modify your copy or copies of the Program or any portion
+of it, thus forming a work based on the Program, and copy and
+distribute such modifications or work under the terms of Section 1
+above, provided that you also meet all of these conditions:
+
+    a) You must cause the modified files to carry prominent notices
+    stating that you changed the files and the date of any change.
+
+    b) You must cause any work that you distribute or publish, that in
+    whole or in part contains or is derived from the Program or any
+    part thereof, to be licensed as a whole at no charge to all third
+    parties under the terms of this License.
+
+    c) If the modified program normally reads commands interactively
+    when run, you must cause it, when started running for such
+    interactive use in the most ordinary way, to print or display an
+    announcement including an appropriate copyright notice and a
+    notice that there is no warranty (or else, saying that you provide
+    a warranty) and that users may redistribute the program under
+    these conditions, and telling the user how to view a copy of this
+    License.  (Exception: if the Program itself is interactive but
+    does not normally print such an announcement, your work based on
+    the Program is not required to print an announcement.)
+
+These requirements apply to the modified work as a whole.  If
+identifiable sections of that work are not derived from the Program,
+and can be reasonably considered independent and separate works in
+themselves, then this License, and its terms, do not apply to those
+sections when you distribute them as separate works.  But when you
+distribute the same sections as part of a whole which is a work based
+on the Program, the distribution of the whole must be on the terms of
+this License, whose permissions for other licensees extend to the
+entire whole, and thus to each and every part regardless of who wrote it.
+
+Thus, it is not the intent of this section to claim rights or contest
+your rights to work written entirely by you; rather, the intent is to
+exercise the right to control the distribution of derivative or
+collective works based on the Program.
+
+In addition, mere aggregation of another work not based on the Program
+with the Program (or with a work based on the Program) on a volume of
+a storage or distribution medium does not bring the other work under
+the scope of this License.
+
+  3. You may copy and distribute the Program (or a work based on it,
+under Section 2) in object code or executable form under the terms of
+Sections 1 and 2 above provided that you also do one of the following:
+
+    a) Accompany it with the complete corresponding machine-readable
+    source code, which must be distributed under the terms of Sections
+    1 and 2 above on a medium customarily used for software interchange; or,
+
+    b) Accompany it with a written offer, valid for at least three
+    years, to give any third party, for a charge no more than your
+    cost of physically performing source distribution, a complete
+    machine-readable copy of the corresponding source code, to be
+    distributed under the terms of Sections 1 and 2 above on a medium
+    customarily used for software interchange; or,
+
+    c) Accompany it with the information you received as to the offer
+    to distribute corresponding source code.  (This alternative is
+    allowed only for noncommercial distribution and only if you
+    received the program in object code or executable form with such
+    an offer, in accord with Subsection b above.)
+
+The source code for a work means the preferred form of the work for
+making modifications to it.  For an executable work, complete source
+code means all the source code for all modules it contains, plus any
+associated interface definition files, plus the scripts used to
+control compilation and installation of the executable.  However, as a
+special exception, the source code distributed need not include
+anything that is normally distributed (in either source or binary
+form) with the major components (compiler, kernel, and so on) of the
+operating system on which the executable runs, unless that component
+itself accompanies the executable.
+
+If distribution of executable or object code is made by offering
+access to copy from a designated place, then offering equivalent
+access to copy the source code from the same place counts as
+distribution of the source code, even though third parties are not
+compelled to copy the source along with the object code.
+
+  4. You may not copy, modify, sublicense, or distribute the Program
+except as expressly provided under this License.  Any attempt
+otherwise to copy, modify, sublicense or distribute the Program is
+void, and will automatically terminate your rights under this License.
+However, parties who have received copies, or rights, from you under
+this License will not have their licenses terminated so long as such
+parties remain in full compliance.
+
+  5. You are not required to accept this License, since you have not
+signed it.  However, nothing else grants you permission to modify or
+distribute the Program or its derivative works.  These actions are
+prohibited by law if you do not accept this License.  Therefore, by
+modifying or distributing the Program (or any work based on the
+Program), you indicate your acceptance of this License to do so, and
+all its terms and conditions for copying, distributing or modifying
+the Program or works based on it.
+
+  6. Each time you redistribute the Program (or any work based on the
+Program), the recipient automatically receives a license from the
+original licensor to copy, distribute or modify the Program subject to
+these terms and conditions.  You may not impose any further
+restrictions on the recipients' exercise of the rights granted herein.
+You are not responsible for enforcing compliance by third parties to
+this License.
+
+  7. If, as a consequence of a court judgment or allegation of patent
+infringement or for any other reason (not limited to patent issues),
+conditions are imposed on you (whether by court order, agreement or
+otherwise) that contradict the conditions of this License, they do not
+excuse you from the conditions of this License.  If you cannot
+distribute so as to satisfy simultaneously your obligations under this
+License and any other pertinent obligations, then as a consequence you
+may not distribute the Program at all.  For example, if a patent
+license would not permit royalty-free redistribution of the Program by
+all those who receive copies directly or indirectly through you, then
+the only way you could satisfy both it and this License would be to
+refrain entirely from distribution of the Program.
+
+If any portion of this section is held invalid or unenforceable under
+any particular circumstance, the balance of the section is intended to
+apply and the section as a whole is intended to apply in other
+circumstances.
+
+It is not the purpose of this section to induce you to infringe any
+patents or other property right claims or to contest validity of any
+such claims; this section has the sole purpose of protecting the
+integrity of the free software distribution system, which is
+implemented by public license practices.  Many people have made
+generous contributions to the wide range of software distributed
+through that system in reliance on consistent application of that
+system; it is up to the author/donor to decide if he or she is willing
+to distribute software through any other system and a licensee cannot
+impose that choice.
+
+This section is intended to make thoroughly clear what is believed to
+be a consequence of the rest of this License.
+
+  8. If the distribution and/or use of the Program is restricted in
+certain countries either by patents or by copyrighted interfaces, the
+original copyright holder who places the Program under this License
+may add an explicit geographical distribution limitation excluding
+those countries, so that distribution is permitted only in or among
+countries not thus excluded.  In such case, this License incorporates
+the limitation as if written in the body of this License.
+
+  9. The Free Software Foundation may publish revised and/or new versions
+of the General Public License from time to time.  Such new versions will
+be similar in spirit to the present version, but may differ in detail to
+address new problems or concerns.
+
+Each version is given a distinguishing version number.  If the Program
+specifies a version number of this License which applies to it and "any
+later version", you have the option of following the terms and conditions
+either of that version or of any later version published by the Free
+Software Foundation.  If the Program does not specify a version number of
+this License, you may choose any version ever published by the Free Software
+Foundation.
+
+  10. If you wish to incorporate parts of the Program into other free
+programs whose distribution conditions are different, write to the author
+to ask for permission.  For software which is copyrighted by the Free
+Software Foundation, write to the Free Software Foundation; we sometimes
+make exceptions for this.  Our decision will be guided by the two goals
+of preserving the free status of all derivatives of our free software and
+of promoting the sharing and reuse of software generally.
+
+			    NO WARRANTY
+
+  11. BECAUSE THE PROGRAM IS LICENSED FREE OF CHARGE, THERE IS NO WARRANTY
+FOR THE PROGRAM, TO THE EXTENT PERMITTED BY APPLICABLE LAW.  EXCEPT WHEN
+OTHERWISE STATED IN WRITING THE COPYRIGHT HOLDERS AND/OR OTHER PARTIES
+PROVIDE THE PROGRAM "AS IS" WITHOUT WARRANTY OF ANY KIND, EITHER EXPRESSED
+OR IMPLIED, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF
+MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE.  THE ENTIRE RISK AS
+TO THE QUALITY AND PERFORMANCE OF THE PROGRAM IS WITH YOU.  SHOULD THE
+PROGRAM PROVE DEFECTIVE, YOU ASSUME THE COST OF ALL NECESSARY SERVICING,
+REPAIR OR CORRECTION.
+
+  12. IN NO EVENT UNLESS REQUIRED BY APPLICABLE LAW OR AGREED TO IN WRITING
+WILL ANY COPYRIGHT HOLDER, OR ANY OTHER PARTY WHO MAY MODIFY AND/OR
+REDISTRIBUTE THE PROGRAM AS PERMITTED ABOVE, BE LIABLE TO YOU FOR DAMAGES,
+INCLUDING ANY GENERAL, SPECIAL, INCIDENTAL OR CONSEQUENTIAL DAMAGES ARISING
+OUT OF THE USE OR INABILITY TO USE THE PROGRAM (INCLUDING BUT NOT LIMITED
+TO LOSS OF DATA OR DATA BEING RENDERED INACCURATE OR LOSSES SUSTAINED BY
+YOU OR THIRD PARTIES OR A FAILURE OF THE PROGRAM TO OPERATE WITH ANY OTHER
+PROGRAMS), EVEN IF SUCH HOLDER OR OTHER PARTY HAS BEEN ADVISED OF THE
+POSSIBILITY OF SUCH DAMAGES.
+
+		     END OF TERMS AND CONDITIONS
+
+	    How to Apply These Terms to Your New Programs
+
+  If you develop a new program, and you want it to be of the greatest
+possible use to the public, the best way to achieve this is to make it
+free software which everyone can redistribute and change under these terms.
+
+  To do so, attach the following notices to the program.  It is safest
+to attach them to the start of each source file to most effectively
+convey the exclusion of warranty; and each file should have at least
+the "copyright" line and a pointer to where the full notice is found.
+
+    <one line to give the program's name and a brief idea of what it does.>
+    Copyright (C) <year>  <name of author>
+
+    This program is free software; you can redistribute it and/or modify
+    it under the terms of the GNU General Public License as published by
+    the Free Software Foundation; either version 2 of the License, or
+    (at your option) any later version.
+
+    This program is distributed in the hope that it will be useful,
+    but WITHOUT ANY WARRANTY; without even the implied warranty of
+    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+    GNU General Public License for more details.
+
+    You should have received a copy of the GNU General Public License
+    along with this program; if not, write to the Free Software
+    Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
+
+
+Also add information on how to contact you by electronic and paper mail.
+
+If the program is interactive, make it output a short notice like this
+when it starts in an interactive mode:
+
+    Gnomovision version 69, Copyright (C) year name of author
+    Gnomovision comes with ABSOLUTELY NO WARRANTY; for details type `show w'.
+    This is free software, and you are welcome to redistribute it
+    under certain conditions; type `show c' for details.
+
+The hypothetical commands `show w' and `show c' should show the appropriate
+parts of the General Public License.  Of course, the commands you use may
+be called something other than `show w' and `show c'; they could even be
+mouse-clicks or menu items--whatever suits your program.
+
+You should also get your employer (if you work as a programmer) or your
+school, if any, to sign a "copyright disclaimer" for the program, if
+necessary.  Here is a sample; alter the names:
+
+  Yoyodyne, Inc., hereby disclaims all copyright interest in the program
+  `Gnomovision' (which makes passes at compilers) written by James Hacker.
+
+  <signature of Ty Coon>, 1 April 1989
+  Ty Coon, President of Vice
+
+This General Public License does not permit incorporating your program into
+proprietary programs.  If your program is a subroutine library, you may
+consider it more useful to permit linking proprietary applications with the
+library.  If this is what you want to do, use the GNU Library General
+Public License instead of this License.
diff --git a/backport/kconf/Kbuild.include b/backport/kconf/Kbuild.include
new file mode 100644
index 000000000000..64492aedcad3
--- /dev/null
+++ b/backport/kconf/Kbuild.include
@@ -0,0 +1,73 @@
+####
+# SPDX-License-Identifier: GPL-2.0
+#
+# kbuild: Generic definitions
+#
+# Simplified Generic definitions for subtree uses. This file is purposely
+# maintained to be as simple as possible. We only carry what we need.
+#
+# Part of the https://github.com/mcgrof/kconfig.git
+
+# Convenient variables
+comma   := ,
+quote   := "
+squote  := '
+empty   :=
+space   := $(empty) $(empty)
+space_escape := _-_SPACE_-_
+pound := \#
+
+###
+# Name of target with a '.' as filename prefix. foo/bar.o => foo/.bar.o
+dot-target = $(dir $@).$(notdir $@)
+
+###
+# The temporary file to save gcc -MD generated dependencies must not
+# contain a comma
+depfile = $(subst $(comma),_,$(dot-target).d)
+
+###
+# filename of target with directory and extension stripped
+basetarget = $(basename $(notdir $@))
+
+###
+# filename of first prerequisite with directory and extension stripped
+baseprereq = $(basename $(notdir $<))
+
+###
+# Escape single quote for use in echo statements
+escsq = $(subst $(squote),'\$(squote)',$1)
+
+###
+# Easy method for doing a status message
+       kecho := :
+ quiet_kecho := echo
+silent_kecho := :
+kecho := $($(quiet)kecho)
+
+###
+# filechk is used to check if the content of a generated file is updated.
+# Sample usage:
+# define filechk_sample
+#	echo $KERNELRELEASE
+# endef
+# version.h : Makefile
+#	$(call filechk,sample)
+# The rule defined shall write to stdout the content of the new file.
+# The existing file will be compared with the new one.
+# - If no file exist it is created
+# - If the content differ the new file is used
+# - If they are equal no change, and no timestamp update
+# - stdin is piped in from the first prerequisite ($<) so one has
+#   to specify a valid file as first prerequisite (often the kbuild file)
+define filechk
+	$(Q)set -e;				\
+	mkdir -p $(dir $@);			\
+	$(filechk_$(1)) > $@.tmp;		\
+	if [ -r $@ ] && cmp -s $@ $@.tmp; then	\
+		rm -f $@.tmp;			\
+	else					\
+		$(kecho) '  UPD     $@';	\
+		mv -f $@.tmp $@;		\
+	fi
+endef
diff --git a/backport/kconf/Makefile b/backport/kconf/Makefile
new file mode 100644
index 000000000000..785bd2dec057
--- /dev/null
+++ b/backport/kconf/Makefile
@@ -0,0 +1,62 @@
+# SPDX-License-Identifier: GPL-2.0
+#
+# Simplified kconfig Makefile for subtree uses. This file is purposely
+# maintained to be as simple as possible. The rest of the files in this
+# directory are meant to match upstream.
+#
+# Part of the https://github.com/mcgrof/kconfig.git
+
+CFLAGS=-Wall -Wmissing-prototypes -Wstrict-prototypes -O2 -fomit-frame-pointer
+LXDIALOG := lxdialog/checklist.o lxdialog/inputbox.o lxdialog/menubox.o lxdialog/textbox.o lxdialog/util.o lxdialog/yesno.o
+
+default: mconf
+
+common-objs := confdata.o expr.o menu.o parser.tab.o lexer.lex.c \
+                   preprocess.o symbol.o util.o
+
+parser.tab.c: parser.y
+	@bison -oparser.tab.c --defines=parser.tab.h -t -l parser.y
+	@flex -olexer.lex.c -L lexer.l
+
+conf: conf.o $(common-objs)
+	$(CC) -o conf $^
+
+mconf_CFLAGS :=  $(shell test -f $(CURDIR)/.mconf-cfg && . $(CURDIR)/.mconf-cfg && echo $$cflags) -DLOCALE
+mconf_LDFLAGS := $(shell test -f $(CURDIR)/.mconf-cfg && . $(CURDIR)/.mconf-cfg && echo $$libs)
+mconf: CFLAGS += ${mconf_CFLAGS}
+
+nconf_CFLAGS :=  $(shell test -f $(CURDIR)/.nconf-cfg && . $(CURDIR)/.nconf-cfg && echo $$cflags) -DLOCALE
+nconf_LDFLAGS := $(shell test -f $(CURDIR)/.nconf-cfg && . $(CURDIR)/.nconf-cfg && echo $$libs)
+nconf: CFLAGS += ${nconf_CFLAGS}
+
+include $(CURDIR)/Kbuild.include
+# check if necessary packages are available, and configure build flags
+define filechk_conf_cfg
+	$(CURDIR)/$<
+endef
+
+.%conf-cfg: %conf-cfg.sh
+	$(call filechk,conf_cfg)
+
+MCONF_DEPS := mconf.o $(LXDIALOG) $(common-objs)
+mconf: .mconf-cfg conf $(MCONF_DEPS)
+	$(CC) -o mconf $(MCONF_DEPS) $(mconf_LDFLAGS)
+
+NCONF_DEPS := nconf.o nconf.gui.o parser.tab.c
+nconf: .nconf-cfg conf $(NCONF_DEPS)
+	$(CC) -o nconf $(NCONF_DEPS) $(nconf_LDFLAGS)
+
+.PHONY: help
+help:
+	@echo "Configuration options:"
+	@echo "menuconfig         - demos the menuconfig functionality"
+	@echo "nconfig            - demos the nconfig functionality"
+	@echo "allyesconfig       - enables all bells and whistles"
+	@echo "allnoconfig        - disables all bells and whistles"
+	@echo "randconfig         - random configuration"
+	@echo "defconfig-*        - If you have files in the defconfig directory use default config from there"
+
+.PHONY: clean
+clean:
+	@rm -f conf mconf conf *.o lxdialog/*.o *.o parser.tab.c .mconf-cfg *.lex.c
+	@rm -rf *.o.d
diff --git a/backport/kconf/README.kconfig b/backport/kconf/README.kconfig
new file mode 100644
index 000000000000..ccd70231c0a8
--- /dev/null
+++ b/backport/kconf/README.kconfig
@@ -0,0 +1,13 @@
+This effort allows for independent projects to use the Linux kernel's
+kconfig on external projects, and make updates of config really easy
+to do. It does this by letting you use this tree as a git subtree.
+
+For more details and to keep this small please refer to a simple demo
+project which demonstrates how to use this and uses it itself:
+
+https://github.com/mcgrof/init-kconfig
+
+The following projects use this git tree as a git subtree as well:
+
+  * https://github.com/mcgrof/kdevops
+  * https://github.com/mcgrof/fio-tests
diff --git a/backport/kconf/conf.c b/backport/kconf/conf.c
new file mode 100644
index 000000000000..4178065ca27f
--- /dev/null
+++ b/backport/kconf/conf.c
@@ -0,0 +1,921 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2002 Roman Zippel <zippel@linux-m68k.org>
+ */
+
+#include <ctype.h>
+#include <limits.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+#include <time.h>
+#include <unistd.h>
+#include <getopt.h>
+#include <sys/time.h>
+#include <errno.h>
+
+#include "lkc.h"
+
+static void conf(struct menu *menu);
+static void check_conf(struct menu *menu);
+
+enum input_mode {
+	oldaskconfig,
+	syncconfig,
+	oldconfig,
+	allnoconfig,
+	allyesconfig,
+	allmodconfig,
+	alldefconfig,
+	randconfig,
+	defconfig,
+	savedefconfig,
+	listnewconfig,
+	helpnewconfig,
+	olddefconfig,
+	yes2modconfig,
+	mod2yesconfig,
+	mod2noconfig,
+};
+static enum input_mode input_mode = oldaskconfig;
+static int input_mode_opt;
+static int indent = 1;
+static int tty_stdio;
+static int sync_kconfig;
+static int conf_cnt;
+static char line[PATH_MAX];
+static struct menu *rootEntry;
+
+static void print_help(struct menu *menu)
+{
+	struct gstr help = str_new();
+
+	menu_get_ext_help(menu, &help);
+
+	printf("\n%s\n", str_get(&help));
+	str_free(&help);
+}
+
+static void strip(char *str)
+{
+	char *p = str;
+	int l;
+
+	while ((isspace(*p)))
+		p++;
+	l = strlen(p);
+	if (p != str)
+		memmove(str, p, l + 1);
+	if (!l)
+		return;
+	p = str + l - 1;
+	while ((isspace(*p)))
+		*p-- = 0;
+}
+
+/* Helper function to facilitate fgets() by Jean Sacren. */
+static void xfgets(char *str, int size, FILE *in)
+{
+	if (!fgets(str, size, in))
+		fprintf(stderr, "\nError in reading or end of file.\n");
+
+	if (!tty_stdio)
+		printf("%s", str);
+}
+
+static void set_randconfig_seed(void)
+{
+	unsigned int seed;
+	char *env;
+	bool seed_set = false;
+
+	env = getenv("KCONFIG_SEED");
+	if (env && *env) {
+		char *endp;
+
+		seed = strtol(env, &endp, 0);
+		if (*endp == '\0')
+			seed_set = true;
+	}
+
+	if (!seed_set) {
+		struct timeval now;
+
+		/*
+		 * Use microseconds derived seed, compensate for systems where it may
+		 * be zero.
+		 */
+		gettimeofday(&now, NULL);
+		seed = (now.tv_sec + 1) * (now.tv_usec + 1);
+	}
+
+	printf("KCONFIG_SEED=0x%X\n", seed);
+	srand(seed);
+}
+
+static bool randomize_choice_values(struct symbol *csym)
+{
+	struct property *prop;
+	struct symbol *sym;
+	struct expr *e;
+	int cnt, def;
+
+	/*
+	 * If choice is mod then we may have more items selected
+	 * and if no then no-one.
+	 * In both cases stop.
+	 */
+	if (csym->curr.tri != yes)
+		return false;
+
+	prop = sym_get_choice_prop(csym);
+
+	/* count entries in choice block */
+	cnt = 0;
+	expr_list_for_each_sym(prop->expr, e, sym)
+		cnt++;
+
+	/*
+	 * find a random value and set it to yes,
+	 * set the rest to no so we have only one set
+	 */
+	def = rand() % cnt;
+
+	cnt = 0;
+	expr_list_for_each_sym(prop->expr, e, sym) {
+		if (def == cnt++) {
+			sym->def[S_DEF_USER].tri = yes;
+			csym->def[S_DEF_USER].val = sym;
+		} else {
+			sym->def[S_DEF_USER].tri = no;
+		}
+		sym->flags |= SYMBOL_DEF_USER;
+		/* clear VALID to get value calculated */
+		sym->flags &= ~SYMBOL_VALID;
+	}
+	csym->flags |= SYMBOL_DEF_USER;
+	/* clear VALID to get value calculated */
+	csym->flags &= ~SYMBOL_VALID;
+
+	return true;
+}
+
+enum conf_def_mode {
+	def_default,
+	def_yes,
+	def_mod,
+	def_no,
+	def_random
+};
+
+static bool conf_set_all_new_symbols(enum conf_def_mode mode)
+{
+	struct symbol *sym, *csym;
+	int i, cnt;
+	/*
+	 * can't go as the default in switch-case below, otherwise gcc whines
+	 * about -Wmaybe-uninitialized
+	 */
+	int pby = 50; /* probability of bool     = y */
+	int pty = 33; /* probability of tristate = y */
+	int ptm = 33; /* probability of tristate = m */
+	bool has_changed = false;
+
+	if (mode == def_random) {
+		int n, p[3];
+		char *env = getenv("KCONFIG_PROBABILITY");
+
+		n = 0;
+		while (env && *env) {
+			char *endp;
+			int tmp = strtol(env, &endp, 10);
+
+			if (tmp >= 0 && tmp <= 100) {
+				p[n++] = tmp;
+			} else {
+				errno = ERANGE;
+				perror("KCONFIG_PROBABILITY");
+				exit(1);
+			}
+			env = (*endp == ':') ? endp + 1 : endp;
+			if (n >= 3)
+				break;
+		}
+		switch (n) {
+		case 1:
+			pby = p[0];
+			ptm = pby / 2;
+			pty = pby - ptm;
+			break;
+		case 2:
+			pty = p[0];
+			ptm = p[1];
+			pby = pty + ptm;
+			break;
+		case 3:
+			pby = p[0];
+			pty = p[1];
+			ptm = p[2];
+			break;
+		}
+
+		if (pty + ptm > 100) {
+			errno = ERANGE;
+			perror("KCONFIG_PROBABILITY");
+			exit(1);
+		}
+	}
+
+	for_all_symbols(i, sym) {
+		if (sym_has_value(sym) || sym->flags & SYMBOL_VALID)
+			continue;
+		switch (sym_get_type(sym)) {
+		case S_BOOLEAN:
+		case S_TRISTATE:
+			has_changed = true;
+			switch (mode) {
+			case def_yes:
+				sym->def[S_DEF_USER].tri = yes;
+				break;
+			case def_mod:
+				sym->def[S_DEF_USER].tri = mod;
+				break;
+			case def_no:
+				sym->def[S_DEF_USER].tri = no;
+				break;
+			case def_random:
+				sym->def[S_DEF_USER].tri = no;
+				cnt = rand() % 100;
+				if (sym->type == S_TRISTATE) {
+					if (cnt < pty)
+						sym->def[S_DEF_USER].tri = yes;
+					else if (cnt < pty + ptm)
+						sym->def[S_DEF_USER].tri = mod;
+				} else if (cnt < pby)
+					sym->def[S_DEF_USER].tri = yes;
+				break;
+			default:
+				continue;
+			}
+			if (!(sym_is_choice(sym) && mode == def_random))
+				sym->flags |= SYMBOL_DEF_USER;
+			break;
+		default:
+			break;
+		}
+
+	}
+
+	sym_clear_all_valid();
+
+	/*
+	 * We have different type of choice blocks.
+	 * If curr.tri equals to mod then we can select several
+	 * choice symbols in one block.
+	 * In this case we do nothing.
+	 * If curr.tri equals yes then only one symbol can be
+	 * selected in a choice block and we set it to yes,
+	 * and the rest to no.
+	 */
+	if (mode != def_random) {
+		for_all_symbols(i, csym) {
+			if ((sym_is_choice(csym) && !sym_has_value(csym)) ||
+			    sym_is_choice_value(csym))
+				csym->flags |= SYMBOL_NEED_SET_CHOICE_VALUES;
+		}
+	}
+
+	for_all_symbols(i, csym) {
+		if (sym_has_value(csym) || !sym_is_choice(csym))
+			continue;
+
+		sym_calc_value(csym);
+		if (mode == def_random)
+			has_changed |= randomize_choice_values(csym);
+		else {
+			set_all_choice_values(csym);
+			has_changed = true;
+		}
+	}
+
+	return has_changed;
+}
+
+static void conf_rewrite_tristates(tristate old_val, tristate new_val)
+{
+	struct symbol *sym;
+	int i;
+
+	for_all_symbols(i, sym) {
+		if (sym_get_type(sym) == S_TRISTATE &&
+		    sym->def[S_DEF_USER].tri == old_val)
+			sym->def[S_DEF_USER].tri = new_val;
+	}
+	sym_clear_all_valid();
+}
+
+static int conf_askvalue(struct symbol *sym, const char *def)
+{
+	if (!sym_has_value(sym))
+		printf("(NEW) ");
+
+	line[0] = '\n';
+	line[1] = 0;
+
+	if (!sym_is_changeable(sym)) {
+		printf("%s\n", def);
+		line[0] = '\n';
+		line[1] = 0;
+		return 0;
+	}
+
+	switch (input_mode) {
+	case oldconfig:
+	case syncconfig:
+		if (sym_has_value(sym)) {
+			printf("%s\n", def);
+			return 0;
+		}
+		/* fall through */
+	default:
+		fflush(stdout);
+		xfgets(line, sizeof(line), stdin);
+		break;
+	}
+
+	return 1;
+}
+
+static int conf_string(struct menu *menu)
+{
+	struct symbol *sym = menu->sym;
+	const char *def;
+
+	while (1) {
+		printf("%*s%s ", indent - 1, "", menu->prompt->text);
+		printf("(%s) ", sym->name);
+		def = sym_get_string_value(sym);
+		if (def)
+			printf("[%s] ", def);
+		if (!conf_askvalue(sym, def))
+			return 0;
+		switch (line[0]) {
+		case '\n':
+			break;
+		case '?':
+			/* print help */
+			if (line[1] == '\n') {
+				print_help(menu);
+				def = NULL;
+				break;
+			}
+			/* fall through */
+		default:
+			line[strlen(line)-1] = 0;
+			def = line;
+		}
+		if (def && sym_set_string_value(sym, def))
+			return 0;
+	}
+}
+
+static int conf_sym(struct menu *menu)
+{
+	struct symbol *sym = menu->sym;
+	tristate oldval, newval;
+
+	while (1) {
+		printf("%*s%s ", indent - 1, "", menu->prompt->text);
+		if (sym->name)
+			printf("(%s) ", sym->name);
+		putchar('[');
+		oldval = sym_get_tristate_value(sym);
+		switch (oldval) {
+		case no:
+			putchar('N');
+			break;
+		case mod:
+			putchar('M');
+			break;
+		case yes:
+			putchar('Y');
+			break;
+		}
+		if (oldval != no && sym_tristate_within_range(sym, no))
+			printf("/n");
+		if (oldval != mod && sym_tristate_within_range(sym, mod))
+			printf("/m");
+		if (oldval != yes && sym_tristate_within_range(sym, yes))
+			printf("/y");
+		printf("/?] ");
+		if (!conf_askvalue(sym, sym_get_string_value(sym)))
+			return 0;
+		strip(line);
+
+		switch (line[0]) {
+		case 'n':
+		case 'N':
+			newval = no;
+			if (!line[1] || !strcmp(&line[1], "o"))
+				break;
+			continue;
+		case 'm':
+		case 'M':
+			newval = mod;
+			if (!line[1])
+				break;
+			continue;
+		case 'y':
+		case 'Y':
+			newval = yes;
+			if (!line[1] || !strcmp(&line[1], "es"))
+				break;
+			continue;
+		case 0:
+			newval = oldval;
+			break;
+		case '?':
+			goto help;
+		default:
+			continue;
+		}
+		if (sym_set_tristate_value(sym, newval))
+			return 0;
+help:
+		print_help(menu);
+	}
+}
+
+static int conf_choice(struct menu *menu)
+{
+	struct symbol *sym, *def_sym;
+	struct menu *child;
+	bool is_new;
+
+	sym = menu->sym;
+	is_new = !sym_has_value(sym);
+	if (sym_is_changeable(sym)) {
+		conf_sym(menu);
+		sym_calc_value(sym);
+		switch (sym_get_tristate_value(sym)) {
+		case no:
+			return 1;
+		case mod:
+			return 0;
+		case yes:
+			break;
+		}
+	} else {
+		switch (sym_get_tristate_value(sym)) {
+		case no:
+			return 1;
+		case mod:
+			printf("%*s%s\n", indent - 1, "", menu_get_prompt(menu));
+			return 0;
+		case yes:
+			break;
+		}
+	}
+
+	while (1) {
+		int cnt, def;
+
+		printf("%*s%s\n", indent - 1, "", menu_get_prompt(menu));
+		def_sym = sym_get_choice_value(sym);
+		cnt = def = 0;
+		line[0] = 0;
+		for (child = menu->list; child; child = child->next) {
+			if (!menu_is_visible(child))
+				continue;
+			if (!child->sym) {
+				printf("%*c %s\n", indent, '*', menu_get_prompt(child));
+				continue;
+			}
+			cnt++;
+			if (child->sym == def_sym) {
+				def = cnt;
+				printf("%*c", indent, '>');
+			} else
+				printf("%*c", indent, ' ');
+			printf(" %d. %s", cnt, menu_get_prompt(child));
+			if (child->sym->name)
+				printf(" (%s)", child->sym->name);
+			if (!sym_has_value(child->sym))
+				printf(" (NEW)");
+			printf("\n");
+		}
+		printf("%*schoice", indent - 1, "");
+		if (cnt == 1) {
+			printf("[1]: 1\n");
+			goto conf_childs;
+		}
+		printf("[1-%d?]: ", cnt);
+		switch (input_mode) {
+		case oldconfig:
+		case syncconfig:
+			if (!is_new) {
+				cnt = def;
+				printf("%d\n", cnt);
+				break;
+			}
+			/* fall through */
+		case oldaskconfig:
+			fflush(stdout);
+			xfgets(line, sizeof(line), stdin);
+			strip(line);
+			if (line[0] == '?') {
+				print_help(menu);
+				continue;
+			}
+			if (!line[0])
+				cnt = def;
+			else if (isdigit(line[0]))
+				cnt = atoi(line);
+			else
+				continue;
+			break;
+		default:
+			break;
+		}
+
+	conf_childs:
+		for (child = menu->list; child; child = child->next) {
+			if (!child->sym || !menu_is_visible(child))
+				continue;
+			if (!--cnt)
+				break;
+		}
+		if (!child)
+			continue;
+		if (line[0] && line[strlen(line) - 1] == '?') {
+			print_help(child);
+			continue;
+		}
+		sym_set_choice_value(sym, child->sym);
+		for (child = child->list; child; child = child->next) {
+			indent += 2;
+			conf(child);
+			indent -= 2;
+		}
+		return 1;
+	}
+}
+
+static void conf(struct menu *menu)
+{
+	struct symbol *sym;
+	struct property *prop;
+	struct menu *child;
+
+	if (!menu_is_visible(menu))
+		return;
+
+	sym = menu->sym;
+	prop = menu->prompt;
+	if (prop) {
+		const char *prompt;
+
+		switch (prop->type) {
+		case P_MENU:
+			/*
+			 * Except in oldaskconfig mode, we show only menus that
+			 * contain new symbols.
+			 */
+			if (input_mode != oldaskconfig && rootEntry != menu) {
+				check_conf(menu);
+				return;
+			}
+			/* fall through */
+		case P_COMMENT:
+			prompt = menu_get_prompt(menu);
+			if (prompt)
+				printf("%*c\n%*c %s\n%*c\n",
+					indent, '*',
+					indent, '*', prompt,
+					indent, '*');
+		default:
+			;
+		}
+	}
+
+	if (!sym)
+		goto conf_childs;
+
+	if (sym_is_choice(sym)) {
+		conf_choice(menu);
+		if (sym->curr.tri != mod)
+			return;
+		goto conf_childs;
+	}
+
+	switch (sym->type) {
+	case S_INT:
+	case S_HEX:
+	case S_STRING:
+		conf_string(menu);
+		break;
+	default:
+		conf_sym(menu);
+		break;
+	}
+
+conf_childs:
+	if (sym)
+		indent += 2;
+	for (child = menu->list; child; child = child->next)
+		conf(child);
+	if (sym)
+		indent -= 2;
+}
+
+static void check_conf(struct menu *menu)
+{
+	struct symbol *sym;
+	struct menu *child;
+
+	if (!menu_is_visible(menu))
+		return;
+
+	sym = menu->sym;
+	if (sym && !sym_has_value(sym) &&
+	    (sym_is_changeable(sym) ||
+	     (sym_is_choice(sym) && sym_get_tristate_value(sym) == yes))) {
+
+		switch (input_mode) {
+		case listnewconfig:
+			if (sym->name)
+				print_symbol_for_listconfig(sym);
+			break;
+		case helpnewconfig:
+			printf("-----\n");
+			print_help(menu);
+			printf("-----\n");
+			break;
+		default:
+			if (!conf_cnt++)
+				printf("*\n* Restart config...\n*\n");
+			rootEntry = menu_get_parent_menu(menu);
+			conf(rootEntry);
+			break;
+		}
+	}
+
+	for (child = menu->list; child; child = child->next)
+		check_conf(child);
+}
+
+static const struct option long_opts[] = {
+	{"help",          no_argument,       NULL,            'h'},
+	{"silent",        no_argument,       NULL,            's'},
+	{"oldaskconfig",  no_argument,       &input_mode_opt, oldaskconfig},
+	{"oldconfig",     no_argument,       &input_mode_opt, oldconfig},
+	{"syncconfig",    no_argument,       &input_mode_opt, syncconfig},
+	{"defconfig",     required_argument, &input_mode_opt, defconfig},
+	{"savedefconfig", required_argument, &input_mode_opt, savedefconfig},
+	{"allnoconfig",   no_argument,       &input_mode_opt, allnoconfig},
+	{"allyesconfig",  no_argument,       &input_mode_opt, allyesconfig},
+	{"allmodconfig",  no_argument,       &input_mode_opt, allmodconfig},
+	{"alldefconfig",  no_argument,       &input_mode_opt, alldefconfig},
+	{"randconfig",    no_argument,       &input_mode_opt, randconfig},
+	{"listnewconfig", no_argument,       &input_mode_opt, listnewconfig},
+	{"helpnewconfig", no_argument,       &input_mode_opt, helpnewconfig},
+	{"olddefconfig",  no_argument,       &input_mode_opt, olddefconfig},
+	{"yes2modconfig", no_argument,       &input_mode_opt, yes2modconfig},
+	{"mod2yesconfig", no_argument,       &input_mode_opt, mod2yesconfig},
+	{"mod2noconfig",  no_argument,       &input_mode_opt, mod2noconfig},
+	{NULL, 0, NULL, 0}
+};
+
+static void conf_usage(const char *progname)
+{
+	printf("Usage: %s [options] <kconfig-file>\n", progname);
+	printf("\n");
+	printf("Generic options:\n");
+	printf("  -h, --help              Print this message and exit.\n");
+	printf("  -s, --silent            Do not print log.\n");
+	printf("\n");
+	printf("Mode options:\n");
+	printf("  --listnewconfig         List new options\n");
+	printf("  --helpnewconfig         List new options and help text\n");
+	printf("  --oldaskconfig          Start a new configuration using a line-oriented program\n");
+	printf("  --oldconfig             Update a configuration using a provided .config as base\n");
+	printf("  --syncconfig            Similar to oldconfig but generates configuration in\n"
+	       "                          include/{generated/,config/}\n");
+	printf("  --olddefconfig          Same as oldconfig but sets new symbols to their default value\n");
+	printf("  --defconfig <file>      New config with default defined in <file>\n");
+	printf("  --savedefconfig <file>  Save the minimal current configuration to <file>\n");
+	printf("  --allnoconfig           New config where all options are answered with no\n");
+	printf("  --allyesconfig          New config where all options are answered with yes\n");
+	printf("  --allmodconfig          New config where all options are answered with mod\n");
+	printf("  --alldefconfig          New config with all symbols set to default\n");
+	printf("  --randconfig            New config with random answer to all options\n");
+	printf("  --yes2modconfig         Change answers from yes to mod if possible\n");
+	printf("  --mod2yesconfig         Change answers from mod to yes if possible\n");
+	printf("  --mod2noconfig          Change answers from mod to no if possible\n");
+	printf("  (If none of the above is given, --oldaskconfig is the default)\n");
+}
+
+int main(int ac, char **av)
+{
+	const char *progname = av[0];
+	int opt;
+	const char *name, *defconfig_file = NULL /* gcc uninit */;
+	int no_conf_write = 0;
+
+	tty_stdio = isatty(0) && isatty(1);
+
+	while ((opt = getopt_long(ac, av, "hs", long_opts, NULL)) != -1) {
+		switch (opt) {
+		case 'h':
+			conf_usage(progname);
+			exit(1);
+			break;
+		case 's':
+			conf_set_message_callback(NULL);
+			break;
+		case 0:
+			input_mode = input_mode_opt;
+			switch (input_mode) {
+			case syncconfig:
+				/*
+				 * syncconfig is invoked during the build stage.
+				 * Suppress distracting
+				 *   "configuration written to ..."
+				 */
+				conf_set_message_callback(NULL);
+				sync_kconfig = 1;
+				break;
+			case defconfig:
+			case savedefconfig:
+				defconfig_file = optarg;
+				break;
+			case randconfig:
+				set_randconfig_seed();
+				break;
+			default:
+				break;
+			}
+		default:
+			break;
+		}
+	}
+	if (ac == optind) {
+		fprintf(stderr, "%s: Kconfig file missing\n", av[0]);
+		conf_usage(progname);
+		exit(1);
+	}
+	conf_parse(av[optind]);
+	//zconfdump(stdout);
+
+	switch (input_mode) {
+	case defconfig:
+		if (conf_read(defconfig_file)) {
+			fprintf(stderr,
+				"***\n"
+				  "*** Can't find default configuration \"%s\"!\n"
+				  "***\n",
+				defconfig_file);
+			exit(1);
+		}
+		break;
+	case savedefconfig:
+	case syncconfig:
+	case oldaskconfig:
+	case oldconfig:
+	case listnewconfig:
+	case helpnewconfig:
+	case olddefconfig:
+	case yes2modconfig:
+	case mod2yesconfig:
+	case mod2noconfig:
+		conf_read(NULL);
+		break;
+	case allnoconfig:
+	case allyesconfig:
+	case allmodconfig:
+	case alldefconfig:
+	case randconfig:
+		name = getenv("KCONFIG_ALLCONFIG");
+		if (!name)
+			break;
+		if ((strcmp(name, "") != 0) && (strcmp(name, "1") != 0)) {
+			if (conf_read_simple(name, S_DEF_USER)) {
+				fprintf(stderr,
+					"*** Can't read seed configuration \"%s\"!\n",
+					name);
+				exit(1);
+			}
+			break;
+		}
+		switch (input_mode) {
+		case allnoconfig:	name = "allno.config"; break;
+		case allyesconfig:	name = "allyes.config"; break;
+		case allmodconfig:	name = "allmod.config"; break;
+		case alldefconfig:	name = "alldef.config"; break;
+		case randconfig:	name = "allrandom.config"; break;
+		default: break;
+		}
+		if (conf_read_simple(name, S_DEF_USER) &&
+		    conf_read_simple("all.config", S_DEF_USER)) {
+			fprintf(stderr,
+				"*** KCONFIG_ALLCONFIG set, but no \"%s\" or \"all.config\" file found\n",
+				name);
+			exit(1);
+		}
+		break;
+	default:
+		break;
+	}
+
+	if (sync_kconfig) {
+		name = getenv("KCONFIG_NOSILENTUPDATE");
+		if (name && *name) {
+			if (conf_get_changed()) {
+				fprintf(stderr,
+					"\n*** The configuration requires explicit update.\n\n");
+				return 1;
+			}
+			no_conf_write = 1;
+		}
+	}
+
+	switch (input_mode) {
+	case allnoconfig:
+		conf_set_all_new_symbols(def_no);
+		break;
+	case allyesconfig:
+		conf_set_all_new_symbols(def_yes);
+		break;
+	case allmodconfig:
+		conf_set_all_new_symbols(def_mod);
+		break;
+	case alldefconfig:
+		conf_set_all_new_symbols(def_default);
+		break;
+	case randconfig:
+		/* Really nothing to do in this loop */
+		while (conf_set_all_new_symbols(def_random)) ;
+		break;
+	case defconfig:
+		conf_set_all_new_symbols(def_default);
+		break;
+	case savedefconfig:
+		break;
+	case yes2modconfig:
+		conf_rewrite_tristates(yes, mod);
+		break;
+	case mod2yesconfig:
+		conf_rewrite_tristates(mod, yes);
+		break;
+	case mod2noconfig:
+		conf_rewrite_tristates(mod, no);
+		break;
+	case oldaskconfig:
+		rootEntry = &rootmenu;
+		conf(&rootmenu);
+		input_mode = oldconfig;
+		/* fall through */
+	case oldconfig:
+	case listnewconfig:
+	case helpnewconfig:
+	case syncconfig:
+		/* Update until a loop caused no more changes */
+		do {
+			conf_cnt = 0;
+			check_conf(&rootmenu);
+		} while (conf_cnt);
+		break;
+	case olddefconfig:
+	default:
+		break;
+	}
+
+	if (input_mode == savedefconfig) {
+		if (conf_write_defconfig(defconfig_file)) {
+			fprintf(stderr, "n*** Error while saving defconfig to: %s\n\n",
+				defconfig_file);
+			return 1;
+		}
+	} else if (input_mode != listnewconfig && input_mode != helpnewconfig) {
+		if (!no_conf_write && conf_write(NULL)) {
+			fprintf(stderr, "\n*** Error during writing of the configuration.\n\n");
+			exit(1);
+		}
+
+		/*
+		 * Create auto.conf if it does not exist.
+		 * This prevents GNU Make 4.1 or older from emitting
+		 * "include/config/auto.conf: No such file or directory"
+		 * in the top-level Makefile
+		 *
+		 * syncconfig always creates or updates auto.conf because it is
+		 * used during the build.
+		 */
+		if (conf_write_autoconf(sync_kconfig) && sync_kconfig) {
+			fprintf(stderr,
+				"\n*** Error during sync of the configuration.\n\n");
+			return 1;
+		}
+	}
+	return 0;
+}
diff --git a/backport/kconf/confdata.c b/backport/kconf/confdata.c
new file mode 100644
index 000000000000..ae54319cdde4
--- /dev/null
+++ b/backport/kconf/confdata.c
@@ -0,0 +1,1262 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2002 Roman Zippel <zippel@linux-m68k.org>
+ */
+
+#include <sys/mman.h>
+#include <sys/stat.h>
+#include <sys/types.h>
+#include <ctype.h>
+#include <errno.h>
+#include <fcntl.h>
+#include <limits.h>
+#include <stdarg.h>
+#include <stdbool.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+#include <time.h>
+#include <unistd.h>
+
+#include "lkc.h"
+
+/* return true if 'path' exists, false otherwise */
+static bool is_present(const char *path)
+{
+	struct stat st;
+
+	return !stat(path, &st);
+}
+
+/* return true if 'path' exists and it is a directory, false otherwise */
+static bool is_dir(const char *path)
+{
+	struct stat st;
+
+	if (stat(path, &st))
+		return false;
+
+	return S_ISDIR(st.st_mode);
+}
+
+/* return true if the given two files are the same, false otherwise */
+static bool is_same(const char *file1, const char *file2)
+{
+	int fd1, fd2;
+	struct stat st1, st2;
+	void *map1, *map2;
+	bool ret = false;
+
+	fd1 = open(file1, O_RDONLY);
+	if (fd1 < 0)
+		return ret;
+
+	fd2 = open(file2, O_RDONLY);
+	if (fd2 < 0)
+		goto close1;
+
+	ret = fstat(fd1, &st1);
+	if (ret)
+		goto close2;
+	ret = fstat(fd2, &st2);
+	if (ret)
+		goto close2;
+
+	if (st1.st_size != st2.st_size)
+		goto close2;
+
+	map1 = mmap(NULL, st1.st_size, PROT_READ, MAP_PRIVATE, fd1, 0);
+	if (map1 == MAP_FAILED)
+		goto close2;
+
+	map2 = mmap(NULL, st2.st_size, PROT_READ, MAP_PRIVATE, fd2, 0);
+	if (map2 == MAP_FAILED)
+		goto close2;
+
+	if (bcmp(map1, map2, st1.st_size))
+		goto close2;
+
+	ret = true;
+close2:
+	close(fd2);
+close1:
+	close(fd1);
+
+	return ret;
+}
+
+/*
+ * Create the parent directory of the given path.
+ *
+ * For example, if 'include/config/auto.conf' is given, create 'include/config'.
+ */
+static int make_parent_dir(const char *path)
+{
+	char tmp[PATH_MAX + 1];
+	char *p;
+
+	strncpy(tmp, path, sizeof(tmp));
+	tmp[sizeof(tmp) - 1] = 0;
+
+	/* Remove the base name. Just return if nothing is left */
+	p = strrchr(tmp, '/');
+	if (!p)
+		return 0;
+	*(p + 1) = 0;
+
+	/* Just in case it is an absolute path */
+	p = tmp;
+	while (*p == '/')
+		p++;
+
+	while ((p = strchr(p, '/'))) {
+		*p = 0;
+
+		/* skip if the directory exists */
+		if (!is_dir(tmp) && mkdir(tmp, 0755))
+			return -1;
+
+		*p = '/';
+		while (*p == '/')
+			p++;
+	}
+
+	return 0;
+}
+
+static char depfile_path[PATH_MAX];
+static size_t depfile_prefix_len;
+
+/* touch depfile for symbol 'name' */
+static int conf_touch_dep(const char *name)
+{
+	int fd;
+
+	/* check overflow: prefix + name + '\0' must fit in buffer. */
+	if (depfile_prefix_len + strlen(name) + 1 > sizeof(depfile_path))
+		return -1;
+
+	strcpy(depfile_path + depfile_prefix_len, name);
+
+	fd = open(depfile_path, O_WRONLY | O_CREAT | O_TRUNC, 0644);
+	if (fd == -1)
+		return -1;
+	close(fd);
+
+	return 0;
+}
+
+static void conf_warning(const char *fmt, ...)
+	__attribute__ ((format (printf, 1, 2)));
+
+static void conf_message(const char *fmt, ...)
+	__attribute__ ((format (printf, 1, 2)));
+
+static const char *conf_filename;
+static int conf_lineno, conf_warnings;
+
+static void conf_warning(const char *fmt, ...)
+{
+	va_list ap;
+	va_start(ap, fmt);
+	fprintf(stderr, "%s:%d:warning: ", conf_filename, conf_lineno);
+	vfprintf(stderr, fmt, ap);
+	fprintf(stderr, "\n");
+	va_end(ap);
+	conf_warnings++;
+}
+
+static void conf_default_message_callback(const char *s)
+{
+	printf("#\n# ");
+	printf("%s", s);
+	printf("\n#\n");
+}
+
+static void (*conf_message_callback)(const char *s) =
+	conf_default_message_callback;
+void conf_set_message_callback(void (*fn)(const char *s))
+{
+	conf_message_callback = fn;
+}
+
+static void conf_message(const char *fmt, ...)
+{
+	va_list ap;
+	char buf[4096];
+
+	if (!conf_message_callback)
+		return;
+
+	va_start(ap, fmt);
+
+	vsnprintf(buf, sizeof(buf), fmt, ap);
+	conf_message_callback(buf);
+	va_end(ap);
+}
+
+const char *conf_get_configname(void)
+{
+	char *name = getenv("KCONFIG_CONFIG");
+
+	return name ? name : ".config";
+}
+
+static const char *conf_get_autoconfig_name(void)
+{
+	char *name = getenv("KCONFIG_AUTOCONFIG");
+
+	return name ? name : "include/config/auto.conf";
+}
+
+static const char *conf_get_autoheader_name(void)
+{
+	char *name = getenv("KCONFIG_AUTOHEADER");
+
+	return name ? name : "include/generated/autoconf.h";
+}
+
+static const char *conf_get_rustccfg_name(void)
+{
+	char *name = getenv("KCONFIG_RUSTCCFG");
+
+	return name ? name : "include/generated/rustc_cfg";
+}
+
+static int conf_set_sym_val(struct symbol *sym, int def, int def_flags, char *p)
+{
+	char *p2;
+
+	switch (sym->type) {
+	case S_TRISTATE:
+		if (p[0] == 'm') {
+			sym->def[def].tri = mod;
+			sym->flags |= def_flags;
+			break;
+		}
+		/* fall through */
+	case S_BOOLEAN:
+		if (p[0] == 'y') {
+			sym->def[def].tri = yes;
+			sym->flags |= def_flags;
+			break;
+		}
+		if (p[0] == 'n') {
+			sym->def[def].tri = no;
+			sym->flags |= def_flags;
+			break;
+		}
+		if (def != S_DEF_AUTO)
+			conf_warning("symbol value '%s' invalid for %s",
+				     p, sym->name);
+		return 1;
+	case S_STRING:
+		/* No escaping for S_DEF_AUTO (include/config/auto.conf) */
+		if (def != S_DEF_AUTO) {
+			if (*p++ != '"')
+				break;
+			for (p2 = p; (p2 = strpbrk(p2, "\"\\")); p2++) {
+				if (*p2 == '"') {
+					*p2 = 0;
+					break;
+				}
+				memmove(p2, p2 + 1, strlen(p2));
+			}
+			if (!p2) {
+				conf_warning("invalid string found");
+				return 1;
+			}
+		}
+		/* fall through */
+	case S_INT:
+	case S_HEX:
+		if (sym_string_valid(sym, p)) {
+			sym->def[def].val = xstrdup(p);
+			sym->flags |= def_flags;
+		} else {
+			if (def != S_DEF_AUTO)
+				conf_warning("symbol value '%s' invalid for %s",
+					     p, sym->name);
+			return 1;
+		}
+		break;
+	default:
+		;
+	}
+	return 0;
+}
+
+#define LINE_GROWTH 16
+static int add_byte(int c, char **lineptr, size_t slen, size_t *n)
+{
+	char *nline;
+	size_t new_size = slen + 1;
+	if (new_size > *n) {
+		new_size += LINE_GROWTH - 1;
+		new_size *= 2;
+		nline = xrealloc(*lineptr, new_size);
+		if (!nline)
+			return -1;
+
+		*lineptr = nline;
+		*n = new_size;
+	}
+
+	(*lineptr)[slen] = c;
+
+	return 0;
+}
+
+static ssize_t compat_getline(char **lineptr, size_t *n, FILE *stream)
+{
+	char *line = *lineptr;
+	size_t slen = 0;
+
+	for (;;) {
+		int c = getc(stream);
+
+		switch (c) {
+		case '\n':
+			if (add_byte(c, &line, slen, n) < 0)
+				goto e_out;
+			slen++;
+			/* fall through */
+		case EOF:
+			if (add_byte('\0', &line, slen, n) < 0)
+				goto e_out;
+			*lineptr = line;
+			if (slen == 0)
+				return -1;
+			return slen;
+		default:
+			if (add_byte(c, &line, slen, n) < 0)
+				goto e_out;
+			slen++;
+		}
+	}
+
+e_out:
+	line[slen-1] = '\0';
+	*lineptr = line;
+	return -1;
+}
+
+int conf_read_simple(const char *name, int def)
+{
+	FILE *in = NULL;
+	char   *line = NULL;
+	size_t  line_asize = 0;
+	char *p, *p2;
+	struct symbol *sym;
+	int i, def_flags;
+
+	if (name) {
+		in = zconf_fopen(name);
+	} else {
+		char *env;
+
+		name = conf_get_configname();
+		in = zconf_fopen(name);
+		if (in)
+			goto load;
+		conf_set_changed(true);
+
+		env = getenv("KCONFIG_DEFCONFIG_LIST");
+		if (!env)
+			return 1;
+
+		while (1) {
+			bool is_last;
+
+			while (isspace(*env))
+				env++;
+
+			if (!*env)
+				break;
+
+			p = env;
+			while (*p && !isspace(*p))
+				p++;
+
+			is_last = (*p == '\0');
+
+			*p = '\0';
+
+			in = zconf_fopen(env);
+			if (in) {
+				conf_message("using defaults found in %s",
+					     env);
+				goto load;
+			}
+
+			if (is_last)
+				break;
+
+			env = p + 1;
+		}
+	}
+	if (!in)
+		return 1;
+
+load:
+	conf_filename = name;
+	conf_lineno = 0;
+	conf_warnings = 0;
+
+	def_flags = SYMBOL_DEF << def;
+	for_all_symbols(i, sym) {
+		sym->flags |= SYMBOL_CHANGED;
+		sym->flags &= ~(def_flags|SYMBOL_VALID);
+		if (sym_is_choice(sym))
+			sym->flags |= def_flags;
+		switch (sym->type) {
+		case S_INT:
+		case S_HEX:
+		case S_STRING:
+			if (sym->def[def].val)
+				free(sym->def[def].val);
+			/* fall through */
+		default:
+			sym->def[def].val = NULL;
+			sym->def[def].tri = no;
+		}
+	}
+
+	while (compat_getline(&line, &line_asize, in) != -1) {
+		conf_lineno++;
+		sym = NULL;
+		if (line[0] == '#') {
+			if (memcmp(line + 2, CONFIG_, strlen(CONFIG_)))
+				continue;
+			p = strchr(line + 2 + strlen(CONFIG_), ' ');
+			if (!p)
+				continue;
+			*p++ = 0;
+			if (strncmp(p, "is not set", 10))
+				continue;
+			if (def == S_DEF_USER) {
+				sym = sym_find(line + 2 + strlen(CONFIG_));
+				if (!sym) {
+					conf_set_changed(true);
+					continue;
+				}
+			} else {
+				sym = sym_lookup(line + 2 + strlen(CONFIG_), 0);
+				if (sym->type == S_UNKNOWN)
+					sym->type = S_BOOLEAN;
+			}
+			if (sym->flags & def_flags) {
+				conf_warning("override: reassigning to symbol %s", sym->name);
+			}
+			switch (sym->type) {
+			case S_BOOLEAN:
+			case S_TRISTATE:
+				sym->def[def].tri = no;
+				sym->flags |= def_flags;
+				break;
+			default:
+				;
+			}
+		} else if (memcmp(line, CONFIG_, strlen(CONFIG_)) == 0) {
+			p = strchr(line + strlen(CONFIG_), '=');
+			if (!p)
+				continue;
+			*p++ = 0;
+			p2 = strchr(p, '\n');
+			if (p2) {
+				*p2-- = 0;
+				if (*p2 == '\r')
+					*p2 = 0;
+			}
+
+			sym = sym_find(line + strlen(CONFIG_));
+			if (!sym) {
+				if (def == S_DEF_AUTO)
+					/*
+					 * Reading from include/config/auto.conf
+					 * If CONFIG_FOO previously existed in
+					 * auto.conf but it is missing now,
+					 * include/config/FOO must be touched.
+					 */
+					conf_touch_dep(line + strlen(CONFIG_));
+				else
+					conf_set_changed(true);
+				continue;
+			}
+
+			if (sym->flags & def_flags) {
+				conf_warning("override: reassigning to symbol %s", sym->name);
+			}
+			if (conf_set_sym_val(sym, def, def_flags, p))
+				continue;
+		} else {
+			if (line[0] != '\r' && line[0] != '\n')
+				conf_warning("unexpected data: %.*s",
+					     (int)strcspn(line, "\r\n"), line);
+
+			continue;
+		}
+
+		if (sym && sym_is_choice_value(sym)) {
+			struct symbol *cs = prop_get_symbol(sym_get_choice_prop(sym));
+			switch (sym->def[def].tri) {
+			case no:
+				break;
+			case mod:
+				if (cs->def[def].tri == yes) {
+					conf_warning("%s creates inconsistent choice state", sym->name);
+					cs->flags &= ~def_flags;
+				}
+				break;
+			case yes:
+				if (cs->def[def].tri != no)
+					conf_warning("override: %s changes choice state", sym->name);
+				cs->def[def].val = sym;
+				break;
+			}
+			cs->def[def].tri = EXPR_OR(cs->def[def].tri, sym->def[def].tri);
+		}
+	}
+	free(line);
+	fclose(in);
+	return 0;
+}
+
+int conf_read(const char *name)
+{
+	struct symbol *sym;
+	int conf_unsaved = 0;
+	int i;
+
+	conf_set_changed(false);
+
+	if (conf_read_simple(name, S_DEF_USER)) {
+		sym_calc_value(modules_sym);
+		return 1;
+	}
+
+	sym_calc_value(modules_sym);
+
+	for_all_symbols(i, sym) {
+		sym_calc_value(sym);
+		if (sym_is_choice(sym) || (sym->flags & SYMBOL_NO_WRITE))
+			continue;
+		if (sym_has_value(sym) && (sym->flags & SYMBOL_WRITE)) {
+			/* check that calculated value agrees with saved value */
+			switch (sym->type) {
+			case S_BOOLEAN:
+			case S_TRISTATE:
+				if (sym->def[S_DEF_USER].tri == sym_get_tristate_value(sym))
+					continue;
+				break;
+			default:
+				if (!strcmp(sym->curr.val, sym->def[S_DEF_USER].val))
+					continue;
+				break;
+			}
+		} else if (!sym_has_value(sym) && !(sym->flags & SYMBOL_WRITE))
+			/* no previous value and not saved */
+			continue;
+		conf_unsaved++;
+		/* maybe print value in verbose mode... */
+	}
+
+	for_all_symbols(i, sym) {
+		if (sym_has_value(sym) && !sym_is_choice_value(sym)) {
+			/* Reset values of generates values, so they'll appear
+			 * as new, if they should become visible, but that
+			 * doesn't quite work if the Kconfig and the saved
+			 * configuration disagree.
+			 */
+			if (sym->visible == no && !conf_unsaved)
+				sym->flags &= ~SYMBOL_DEF_USER;
+			switch (sym->type) {
+			case S_STRING:
+			case S_INT:
+			case S_HEX:
+				/* Reset a string value if it's out of range */
+				if (sym_string_within_range(sym, sym->def[S_DEF_USER].val))
+					break;
+				sym->flags &= ~(SYMBOL_VALID|SYMBOL_DEF_USER);
+				conf_unsaved++;
+				break;
+			default:
+				break;
+			}
+		}
+	}
+
+	if (conf_warnings || conf_unsaved)
+		conf_set_changed(true);
+
+	return 0;
+}
+
+struct comment_style {
+	const char *decoration;
+	const char *prefix;
+	const char *postfix;
+};
+
+static const struct comment_style comment_style_pound = {
+	.decoration = "#",
+	.prefix = "#",
+	.postfix = "#",
+};
+
+static const struct comment_style comment_style_c = {
+	.decoration = " *",
+	.prefix = "/*",
+	.postfix = " */",
+};
+
+static void conf_write_heading(FILE *fp, const struct comment_style *cs)
+{
+	if (!cs)
+		return;
+
+	fprintf(fp, "%s\n", cs->prefix);
+
+	fprintf(fp, "%s Automatically generated file; DO NOT EDIT.\n",
+		cs->decoration);
+
+	fprintf(fp, "%s %s\n", cs->decoration, rootmenu.prompt->text);
+
+	fprintf(fp, "%s\n", cs->postfix);
+}
+
+/* The returned pointer must be freed on the caller side */
+static char *escape_string_value(const char *in)
+{
+	const char *p;
+	char *out;
+	size_t len;
+
+	len = strlen(in) + strlen("\"\"") + 1;
+
+	p = in;
+	while (1) {
+		p += strcspn(p, "\"\\");
+
+		if (p[0] == '\0')
+			break;
+
+		len++;
+		p++;
+	}
+
+	out = xmalloc(len);
+	out[0] = '\0';
+
+	strcat(out, "\"");
+
+	p = in;
+	while (1) {
+		len = strcspn(p, "\"\\");
+		strncat(out, p, len);
+		p += len;
+
+		if (p[0] == '\0')
+			break;
+
+		strcat(out, "\\");
+		strncat(out, p++, 1);
+	}
+
+	strcat(out, "\"");
+
+	return out;
+}
+
+/*
+ * Kconfig configuration printer
+ *
+ * This printer is used when generating the resulting configuration after
+ * kconfig invocation and `defconfig' files. Unset symbol might be omitted by
+ * passing a non-NULL argument to the printer.
+ */
+enum output_n { OUTPUT_N, OUTPUT_N_AS_UNSET, OUTPUT_N_NONE };
+
+static void __print_symbol(FILE *fp, struct symbol *sym, enum output_n output_n,
+			   bool escape_string)
+{
+	const char *val;
+	char *escaped = NULL;
+
+	if (sym->type == S_UNKNOWN)
+		return;
+
+	val = sym_get_string_value(sym);
+
+	if ((sym->type == S_BOOLEAN || sym->type == S_TRISTATE) &&
+	    output_n != OUTPUT_N && *val == 'n') {
+		if (output_n == OUTPUT_N_AS_UNSET)
+			fprintf(fp, "# %s%s is not set\n", CONFIG_, sym->name);
+		return;
+	}
+
+	if (sym->type == S_STRING && escape_string) {
+		escaped = escape_string_value(val);
+		val = escaped;
+	}
+
+	fprintf(fp, "%s%s=%s\n", CONFIG_, sym->name, val);
+
+	free(escaped);
+}
+
+static void print_symbol_for_dotconfig(FILE *fp, struct symbol *sym)
+{
+	__print_symbol(fp, sym, OUTPUT_N_AS_UNSET, true);
+}
+
+static void print_symbol_for_autoconf(FILE *fp, struct symbol *sym)
+{
+	__print_symbol(fp, sym, OUTPUT_N_NONE, false);
+}
+
+void print_symbol_for_listconfig(struct symbol *sym)
+{
+	__print_symbol(stdout, sym, OUTPUT_N, true);
+}
+
+static void print_symbol_for_c(FILE *fp, struct symbol *sym)
+{
+	const char *val;
+	const char *sym_suffix = "";
+	const char *val_prefix = "";
+	char *escaped = NULL;
+
+	if (sym->type == S_UNKNOWN)
+		return;
+
+	val = sym_get_string_value(sym);
+
+	switch (sym->type) {
+	case S_BOOLEAN:
+	case S_TRISTATE:
+		switch (*val) {
+		case 'n':
+			return;
+		case 'm':
+			sym_suffix = "_MODULE";
+			/* fall through */
+		default:
+			val = "1";
+		}
+		break;
+	case S_HEX:
+		if (val[0] != '0' || (val[1] != 'x' && val[1] != 'X'))
+			val_prefix = "0x";
+		break;
+	case S_STRING:
+		escaped = escape_string_value(val);
+		val = escaped;
+	default:
+		break;
+	}
+
+	fprintf(fp, "#define %s%s%s %s%s\n", CONFIG_, sym->name, sym_suffix,
+		val_prefix, val);
+
+	free(escaped);
+}
+
+static void print_symbol_for_rustccfg(FILE *fp, struct symbol *sym)
+{
+	const char *val;
+	const char *val_prefix = "";
+	char *val_prefixed = NULL;
+	size_t val_prefixed_len;
+	char *escaped = NULL;
+
+	if (sym->type == S_UNKNOWN)
+		return;
+
+	val = sym_get_string_value(sym);
+
+	switch (sym->type) {
+	case S_BOOLEAN:
+	case S_TRISTATE:
+		/*
+		 * We do not care about disabled ones, i.e. no need for
+		 * what otherwise are "comments" in other printers.
+		 */
+		if (*val == 'n')
+			return;
+
+		/*
+		 * To have similar functionality to the C macro `IS_ENABLED()`
+		 * we provide an empty `--cfg CONFIG_X` here in both `y`
+		 * and `m` cases.
+		 *
+		 * Then, the common `fprintf()` below will also give us
+		 * a `--cfg CONFIG_X="y"` or `--cfg CONFIG_X="m"`, which can
+		 * be used as the equivalent of `IS_BUILTIN()`/`IS_MODULE()`.
+		 */
+		fprintf(fp, "--cfg=%s%s\n", CONFIG_, sym->name);
+		break;
+	case S_HEX:
+		if (val[0] != '0' || (val[1] != 'x' && val[1] != 'X'))
+			val_prefix = "0x";
+		break;
+	default:
+		break;
+	}
+
+	if (strlen(val_prefix) > 0) {
+		val_prefixed_len = strlen(val) + strlen(val_prefix) + 1;
+		val_prefixed = xmalloc(val_prefixed_len);
+		snprintf(val_prefixed, val_prefixed_len, "%s%s", val_prefix, val);
+		val = val_prefixed;
+	}
+
+	/* All values get escaped: the `--cfg` option only takes strings */
+	escaped = escape_string_value(val);
+	val = escaped;
+
+	fprintf(fp, "--cfg=%s%s=%s\n", CONFIG_, sym->name, val);
+
+	free(escaped);
+	free(val_prefixed);
+}
+
+/*
+ * Write out a minimal config.
+ * All values that has default values are skipped as this is redundant.
+ */
+int conf_write_defconfig(const char *filename)
+{
+	struct symbol *sym;
+	struct menu *menu;
+	FILE *out;
+
+	out = fopen(filename, "w");
+	if (!out)
+		return 1;
+
+	sym_clear_all_valid();
+
+	/* Traverse all menus to find all relevant symbols */
+	menu = rootmenu.list;
+
+	while (menu != NULL)
+	{
+		sym = menu->sym;
+		if (sym == NULL) {
+			if (!menu_is_visible(menu))
+				goto next_menu;
+		} else if (!sym_is_choice(sym)) {
+			sym_calc_value(sym);
+			if (!(sym->flags & SYMBOL_WRITE))
+				goto next_menu;
+			sym->flags &= ~SYMBOL_WRITE;
+			/* If we cannot change the symbol - skip */
+			if (!sym_is_changeable(sym))
+				goto next_menu;
+			/* If symbol equals to default value - skip */
+			if (strcmp(sym_get_string_value(sym), sym_get_string_default(sym)) == 0)
+				goto next_menu;
+
+			/*
+			 * If symbol is a choice value and equals to the
+			 * default for a choice - skip.
+			 * But only if value is bool and equal to "y" and
+			 * choice is not "optional".
+			 * (If choice is "optional" then all values can be "n")
+			 */
+			if (sym_is_choice_value(sym)) {
+				struct symbol *cs;
+				struct symbol *ds;
+
+				cs = prop_get_symbol(sym_get_choice_prop(sym));
+				ds = sym_choice_default(cs);
+				if (!sym_is_optional(cs) && sym == ds) {
+					if ((sym->type == S_BOOLEAN) &&
+					    sym_get_tristate_value(sym) == yes)
+						goto next_menu;
+				}
+			}
+			print_symbol_for_dotconfig(out, sym);
+		}
+next_menu:
+		if (menu->list != NULL) {
+			menu = menu->list;
+		}
+		else if (menu->next != NULL) {
+			menu = menu->next;
+		} else {
+			while ((menu = menu->parent)) {
+				if (menu->next != NULL) {
+					menu = menu->next;
+					break;
+				}
+			}
+		}
+	}
+	fclose(out);
+	return 0;
+}
+
+int conf_write(const char *name)
+{
+	FILE *out;
+	struct symbol *sym;
+	struct menu *menu;
+	const char *str;
+	char tmpname[PATH_MAX + 1], oldname[PATH_MAX + 1];
+	char *env;
+	int i;
+	bool need_newline = false;
+
+	if (!name)
+		name = conf_get_configname();
+
+	if (!*name) {
+		fprintf(stderr, "config name is empty\n");
+		return -1;
+	}
+
+	if (is_dir(name)) {
+		fprintf(stderr, "%s: Is a directory\n", name);
+		return -1;
+	}
+
+	if (make_parent_dir(name))
+		return -1;
+
+	env = getenv("KCONFIG_OVERWRITECONFIG");
+	if (env && *env) {
+		*tmpname = 0;
+		out = fopen(name, "w");
+	} else {
+		snprintf(tmpname, sizeof(tmpname), "%s.%d.tmp",
+			 name, (int)getpid());
+		out = fopen(tmpname, "w");
+	}
+	if (!out)
+		return 1;
+
+	conf_write_heading(out, &comment_style_pound);
+
+	if (!conf_get_changed())
+		sym_clear_all_valid();
+
+	menu = rootmenu.list;
+	while (menu) {
+		sym = menu->sym;
+		if (!sym) {
+			if (!menu_is_visible(menu))
+				goto next;
+			str = menu_get_prompt(menu);
+			fprintf(out, "\n"
+				     "#\n"
+				     "# %s\n"
+				     "#\n", str);
+			need_newline = false;
+		} else if (!(sym->flags & SYMBOL_CHOICE) &&
+			   !(sym->flags & SYMBOL_WRITTEN)) {
+			sym_calc_value(sym);
+			if (!(sym->flags & SYMBOL_WRITE))
+				goto next;
+			if (need_newline) {
+				fprintf(out, "\n");
+				need_newline = false;
+			}
+			sym->flags |= SYMBOL_WRITTEN;
+			print_symbol_for_dotconfig(out, sym);
+		}
+
+next:
+		if (menu->list) {
+			menu = menu->list;
+			continue;
+		}
+		if (menu->next)
+			menu = menu->next;
+		else while ((menu = menu->parent)) {
+			if (!menu->sym && menu_is_visible(menu) &&
+			    menu != &rootmenu) {
+				str = menu_get_prompt(menu);
+				fprintf(out, "# end of %s\n", str);
+				need_newline = true;
+			}
+			if (menu->next) {
+				menu = menu->next;
+				break;
+			}
+		}
+	}
+	fclose(out);
+
+	for_all_symbols(i, sym)
+		sym->flags &= ~SYMBOL_WRITTEN;
+
+	if (*tmpname) {
+		if (is_same(name, tmpname)) {
+			conf_message("No change to %s", name);
+			unlink(tmpname);
+			conf_set_changed(false);
+			return 0;
+		}
+
+		snprintf(oldname, sizeof(oldname), "%s.old", name);
+		rename(name, oldname);
+		if (rename(tmpname, name))
+			return 1;
+	}
+
+	conf_message("configuration written to %s", name);
+
+	conf_set_changed(false);
+
+	return 0;
+}
+
+/* write a dependency file as used by kbuild to track dependencies */
+static int conf_write_autoconf_cmd(const char *autoconf_name)
+{
+	char name[PATH_MAX], tmp[PATH_MAX];
+	struct file *file;
+	FILE *out;
+	int ret;
+
+	ret = snprintf(name, sizeof(name), "%s.cmd", autoconf_name);
+	if (ret >= sizeof(name)) /* check truncation */
+		return -1;
+
+	if (make_parent_dir(name))
+		return -1;
+
+	ret = snprintf(tmp, sizeof(tmp), "%s.cmd.tmp", autoconf_name);
+	if (ret >= sizeof(tmp)) /* check truncation */
+		return -1;
+
+	out = fopen(tmp, "w");
+	if (!out) {
+		perror("fopen");
+		return -1;
+	}
+
+	fprintf(out, "deps_config := \\\n");
+	for (file = file_list; file; file = file->next)
+		fprintf(out, "\t%s \\\n", file->name);
+
+	fprintf(out, "\n%s: $(deps_config)\n\n", autoconf_name);
+
+	env_write_dep(out, autoconf_name);
+
+	fprintf(out, "\n$(deps_config): ;\n");
+
+	if (ferror(out)) /* error check for all fprintf() calls */
+		return -1;
+
+	fclose(out);
+
+	if (rename(tmp, name)) {
+		perror("rename");
+		return -1;
+	}
+
+	return 0;
+}
+
+static int conf_touch_deps(void)
+{
+	const char *name;
+	struct symbol *sym;
+	int res, i;
+
+	strcpy(depfile_path, "include/config/");
+	depfile_prefix_len = strlen(depfile_path);
+
+	name = conf_get_autoconfig_name();
+	conf_read_simple(name, S_DEF_AUTO);
+	sym_calc_value(modules_sym);
+
+	for_all_symbols(i, sym) {
+		sym_calc_value(sym);
+		if ((sym->flags & SYMBOL_NO_WRITE) || !sym->name)
+			continue;
+		if (sym->flags & SYMBOL_WRITE) {
+			if (sym->flags & SYMBOL_DEF_AUTO) {
+				/*
+				 * symbol has old and new value,
+				 * so compare them...
+				 */
+				switch (sym->type) {
+				case S_BOOLEAN:
+				case S_TRISTATE:
+					if (sym_get_tristate_value(sym) ==
+					    sym->def[S_DEF_AUTO].tri)
+						continue;
+					break;
+				case S_STRING:
+				case S_HEX:
+				case S_INT:
+					if (!strcmp(sym_get_string_value(sym),
+						    sym->def[S_DEF_AUTO].val))
+						continue;
+					break;
+				default:
+					break;
+				}
+			} else {
+				/*
+				 * If there is no old value, only 'no' (unset)
+				 * is allowed as new value.
+				 */
+				switch (sym->type) {
+				case S_BOOLEAN:
+				case S_TRISTATE:
+					if (sym_get_tristate_value(sym) == no)
+						continue;
+					break;
+				default:
+					break;
+				}
+			}
+		} else if (!(sym->flags & SYMBOL_DEF_AUTO))
+			/* There is neither an old nor a new value. */
+			continue;
+		/* else
+		 *	There is an old value, but no new value ('no' (unset)
+		 *	isn't saved in auto.conf, so the old value is always
+		 *	different from 'no').
+		 */
+
+		res = conf_touch_dep(sym->name);
+		if (res)
+			return res;
+	}
+
+	return 0;
+}
+
+static int __conf_write_autoconf(const char *filename,
+				 void (*print_symbol)(FILE *, struct symbol *),
+				 const struct comment_style *comment_style)
+{
+	char tmp[PATH_MAX];
+	FILE *file;
+	struct symbol *sym;
+	int ret, i;
+
+	if (make_parent_dir(filename))
+		return -1;
+
+	ret = snprintf(tmp, sizeof(tmp), "%s.tmp", filename);
+	if (ret >= sizeof(tmp)) /* check truncation */
+		return -1;
+
+	file = fopen(tmp, "w");
+	if (!file) {
+		perror("fopen");
+		return -1;
+	}
+
+	conf_write_heading(file, comment_style);
+
+	for_all_symbols(i, sym)
+		if ((sym->flags & SYMBOL_WRITE) && sym->name)
+			print_symbol(file, sym);
+
+	/* check possible errors in conf_write_heading() and print_symbol() */
+	if (ferror(file))
+		return -1;
+
+	fclose(file);
+
+	if (rename(tmp, filename)) {
+		perror("rename");
+		return -1;
+	}
+
+	return 0;
+}
+
+int conf_write_autoconf(int overwrite)
+{
+	struct symbol *sym;
+	const char *autoconf_name = conf_get_autoconfig_name();
+	int ret, i;
+
+	if (!overwrite && is_present(autoconf_name))
+		return 0;
+
+	ret = conf_write_autoconf_cmd(autoconf_name);
+	if (ret)
+		return -1;
+
+	if (conf_touch_deps())
+		return 1;
+
+	for_all_symbols(i, sym)
+		sym_calc_value(sym);
+
+	ret = __conf_write_autoconf(conf_get_autoheader_name(),
+				    print_symbol_for_c,
+				    &comment_style_c);
+	if (ret)
+		return ret;
+
+	ret = __conf_write_autoconf(conf_get_rustccfg_name(),
+				    print_symbol_for_rustccfg,
+				    NULL);
+	if (ret)
+		return ret;
+
+	/*
+	 * Create include/config/auto.conf. This must be the last step because
+	 * Kbuild has a dependency on auto.conf and this marks the successful
+	 * completion of the previous steps.
+	 */
+	ret = __conf_write_autoconf(conf_get_autoconfig_name(),
+				    print_symbol_for_autoconf,
+				    &comment_style_pound);
+	if (ret)
+		return ret;
+
+	return 0;
+}
+
+static bool conf_changed;
+static void (*conf_changed_callback)(void);
+
+void conf_set_changed(bool val)
+{
+	if (conf_changed_callback && conf_changed != val)
+		conf_changed_callback();
+
+	conf_changed = val;
+}
+
+bool conf_get_changed(void)
+{
+	return conf_changed;
+}
+
+void conf_set_changed_callback(void (*fn)(void))
+{
+	conf_changed_callback = fn;
+}
+
+void set_all_choice_values(struct symbol *csym)
+{
+	struct property *prop;
+	struct symbol *sym;
+	struct expr *e;
+
+	prop = sym_get_choice_prop(csym);
+
+	/*
+	 * Set all non-assinged choice values to no
+	 */
+	expr_list_for_each_sym(prop->expr, e, sym) {
+		if (!sym_has_value(sym))
+			sym->def[S_DEF_USER].tri = no;
+	}
+	csym->flags |= SYMBOL_DEF_USER;
+	/* clear VALID to get value calculated */
+	csym->flags &= ~(SYMBOL_VALID | SYMBOL_NEED_SET_CHOICE_VALUES);
+}
diff --git a/backport/kconf/expr.c b/backport/kconf/expr.c
new file mode 100644
index 000000000000..81ebf8108ca7
--- /dev/null
+++ b/backport/kconf/expr.c
@@ -0,0 +1,1303 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2002 Roman Zippel <zippel@linux-m68k.org>
+ */
+
+#include <ctype.h>
+#include <errno.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+
+#include "lkc.h"
+
+#define DEBUG_EXPR	0
+
+static struct expr *expr_eliminate_yn(struct expr *e);
+
+struct expr *expr_alloc_symbol(struct symbol *sym)
+{
+	struct expr *e = xcalloc(1, sizeof(*e));
+	e->type = E_SYMBOL;
+	e->left.sym = sym;
+	return e;
+}
+
+struct expr *expr_alloc_one(enum expr_type type, struct expr *ce)
+{
+	struct expr *e = xcalloc(1, sizeof(*e));
+	e->type = type;
+	e->left.expr = ce;
+	return e;
+}
+
+struct expr *expr_alloc_two(enum expr_type type, struct expr *e1, struct expr *e2)
+{
+	struct expr *e = xcalloc(1, sizeof(*e));
+	e->type = type;
+	e->left.expr = e1;
+	e->right.expr = e2;
+	return e;
+}
+
+struct expr *expr_alloc_comp(enum expr_type type, struct symbol *s1, struct symbol *s2)
+{
+	struct expr *e = xcalloc(1, sizeof(*e));
+	e->type = type;
+	e->left.sym = s1;
+	e->right.sym = s2;
+	return e;
+}
+
+struct expr *expr_alloc_and(struct expr *e1, struct expr *e2)
+{
+	if (!e1)
+		return e2;
+	return e2 ? expr_alloc_two(E_AND, e1, e2) : e1;
+}
+
+struct expr *expr_alloc_or(struct expr *e1, struct expr *e2)
+{
+	if (!e1)
+		return e2;
+	return e2 ? expr_alloc_two(E_OR, e1, e2) : e1;
+}
+
+struct expr *expr_copy(const struct expr *org)
+{
+	struct expr *e;
+
+	if (!org)
+		return NULL;
+
+	e = xmalloc(sizeof(*org));
+	memcpy(e, org, sizeof(*org));
+	switch (org->type) {
+	case E_SYMBOL:
+		e->left = org->left;
+		break;
+	case E_NOT:
+		e->left.expr = expr_copy(org->left.expr);
+		break;
+	case E_EQUAL:
+	case E_GEQ:
+	case E_GTH:
+	case E_LEQ:
+	case E_LTH:
+	case E_UNEQUAL:
+		e->left.sym = org->left.sym;
+		e->right.sym = org->right.sym;
+		break;
+	case E_AND:
+	case E_OR:
+	case E_LIST:
+		e->left.expr = expr_copy(org->left.expr);
+		e->right.expr = expr_copy(org->right.expr);
+		break;
+	default:
+		fprintf(stderr, "can't copy type %d\n", e->type);
+		free(e);
+		e = NULL;
+		break;
+	}
+
+	return e;
+}
+
+void expr_free(struct expr *e)
+{
+	if (!e)
+		return;
+
+	switch (e->type) {
+	case E_SYMBOL:
+		break;
+	case E_NOT:
+		expr_free(e->left.expr);
+		break;
+	case E_EQUAL:
+	case E_GEQ:
+	case E_GTH:
+	case E_LEQ:
+	case E_LTH:
+	case E_UNEQUAL:
+		break;
+	case E_OR:
+	case E_AND:
+		expr_free(e->left.expr);
+		expr_free(e->right.expr);
+		break;
+	default:
+		fprintf(stderr, "how to free type %d?\n", e->type);
+		break;
+	}
+	free(e);
+}
+
+static int trans_count;
+
+#define e1 (*ep1)
+#define e2 (*ep2)
+
+/*
+ * expr_eliminate_eq() helper.
+ *
+ * Walks the two expression trees given in 'ep1' and 'ep2'. Any node that does
+ * not have type 'type' (E_OR/E_AND) is considered a leaf, and is compared
+ * against all other leaves. Two equal leaves are both replaced with either 'y'
+ * or 'n' as appropriate for 'type', to be eliminated later.
+ */
+static void __expr_eliminate_eq(enum expr_type type, struct expr **ep1, struct expr **ep2)
+{
+	/* Recurse down to leaves */
+
+	if (e1->type == type) {
+		__expr_eliminate_eq(type, &e1->left.expr, &e2);
+		__expr_eliminate_eq(type, &e1->right.expr, &e2);
+		return;
+	}
+	if (e2->type == type) {
+		__expr_eliminate_eq(type, &e1, &e2->left.expr);
+		__expr_eliminate_eq(type, &e1, &e2->right.expr);
+		return;
+	}
+
+	/* e1 and e2 are leaves. Compare them. */
+
+	if (e1->type == E_SYMBOL && e2->type == E_SYMBOL &&
+	    e1->left.sym == e2->left.sym &&
+	    (e1->left.sym == &symbol_yes || e1->left.sym == &symbol_no))
+		return;
+	if (!expr_eq(e1, e2))
+		return;
+
+	/* e1 and e2 are equal leaves. Prepare them for elimination. */
+
+	trans_count++;
+	expr_free(e1); expr_free(e2);
+	switch (type) {
+	case E_OR:
+		e1 = expr_alloc_symbol(&symbol_no);
+		e2 = expr_alloc_symbol(&symbol_no);
+		break;
+	case E_AND:
+		e1 = expr_alloc_symbol(&symbol_yes);
+		e2 = expr_alloc_symbol(&symbol_yes);
+		break;
+	default:
+		;
+	}
+}
+
+/*
+ * Rewrites the expressions 'ep1' and 'ep2' to remove operands common to both.
+ * Example reductions:
+ *
+ *	ep1: A && B           ->  ep1: y
+ *	ep2: A && B && C      ->  ep2: C
+ *
+ *	ep1: A || B           ->  ep1: n
+ *	ep2: A || B || C      ->  ep2: C
+ *
+ *	ep1: A && (B && FOO)  ->  ep1: FOO
+ *	ep2: (BAR && B) && A  ->  ep2: BAR
+ *
+ *	ep1: A && (B || C)    ->  ep1: y
+ *	ep2: (C || B) && A    ->  ep2: y
+ *
+ * Comparisons are done between all operands at the same "level" of && or ||.
+ * For example, in the expression 'e1 && (e2 || e3) && (e4 || e5)', the
+ * following operands will be compared:
+ *
+ *	- 'e1', 'e2 || e3', and 'e4 || e5', against each other
+ *	- e2 against e3
+ *	- e4 against e5
+ *
+ * Parentheses are irrelevant within a single level. 'e1 && (e2 && e3)' and
+ * '(e1 && e2) && e3' are both a single level.
+ *
+ * See __expr_eliminate_eq() as well.
+ */
+void expr_eliminate_eq(struct expr **ep1, struct expr **ep2)
+{
+	if (!e1 || !e2)
+		return;
+	switch (e1->type) {
+	case E_OR:
+	case E_AND:
+		__expr_eliminate_eq(e1->type, ep1, ep2);
+	default:
+		;
+	}
+	if (e1->type != e2->type) switch (e2->type) {
+	case E_OR:
+	case E_AND:
+		__expr_eliminate_eq(e2->type, ep1, ep2);
+	default:
+		;
+	}
+	e1 = expr_eliminate_yn(e1);
+	e2 = expr_eliminate_yn(e2);
+}
+
+#undef e1
+#undef e2
+
+/*
+ * Returns true if 'e1' and 'e2' are equal, after minor simplification. Two
+ * &&/|| expressions are considered equal if every operand in one expression
+ * equals some operand in the other (operands do not need to appear in the same
+ * order), recursively.
+ */
+int expr_eq(struct expr *e1, struct expr *e2)
+{
+	int res, old_count;
+
+	/*
+	 * A NULL expr is taken to be yes, but there's also a different way to
+	 * represent yes. expr_is_yes() checks for either representation.
+	 */
+	if (!e1 || !e2)
+		return expr_is_yes(e1) && expr_is_yes(e2);
+
+	if (e1->type != e2->type)
+		return 0;
+	switch (e1->type) {
+	case E_EQUAL:
+	case E_GEQ:
+	case E_GTH:
+	case E_LEQ:
+	case E_LTH:
+	case E_UNEQUAL:
+		return e1->left.sym == e2->left.sym && e1->right.sym == e2->right.sym;
+	case E_SYMBOL:
+		return e1->left.sym == e2->left.sym;
+	case E_NOT:
+		return expr_eq(e1->left.expr, e2->left.expr);
+	case E_AND:
+	case E_OR:
+		e1 = expr_copy(e1);
+		e2 = expr_copy(e2);
+		old_count = trans_count;
+		expr_eliminate_eq(&e1, &e2);
+		res = (e1->type == E_SYMBOL && e2->type == E_SYMBOL &&
+		       e1->left.sym == e2->left.sym);
+		expr_free(e1);
+		expr_free(e2);
+		trans_count = old_count;
+		return res;
+	case E_LIST:
+	case E_RANGE:
+	case E_NONE:
+		/* panic */;
+	}
+
+	if (DEBUG_EXPR) {
+		expr_fprint(e1, stdout);
+		printf(" = ");
+		expr_fprint(e2, stdout);
+		printf(" ?\n");
+	}
+
+	return 0;
+}
+
+/*
+ * Recursively performs the following simplifications in-place (as well as the
+ * corresponding simplifications with swapped operands):
+ *
+ *	expr && n  ->  n
+ *	expr && y  ->  expr
+ *	expr || n  ->  expr
+ *	expr || y  ->  y
+ *
+ * Returns the optimized expression.
+ */
+static struct expr *expr_eliminate_yn(struct expr *e)
+{
+	struct expr *tmp;
+
+	if (e) switch (e->type) {
+	case E_AND:
+		e->left.expr = expr_eliminate_yn(e->left.expr);
+		e->right.expr = expr_eliminate_yn(e->right.expr);
+		if (e->left.expr->type == E_SYMBOL) {
+			if (e->left.expr->left.sym == &symbol_no) {
+				expr_free(e->left.expr);
+				expr_free(e->right.expr);
+				e->type = E_SYMBOL;
+				e->left.sym = &symbol_no;
+				e->right.expr = NULL;
+				return e;
+			} else if (e->left.expr->left.sym == &symbol_yes) {
+				free(e->left.expr);
+				tmp = e->right.expr;
+				*e = *(e->right.expr);
+				free(tmp);
+				return e;
+			}
+		}
+		if (e->right.expr->type == E_SYMBOL) {
+			if (e->right.expr->left.sym == &symbol_no) {
+				expr_free(e->left.expr);
+				expr_free(e->right.expr);
+				e->type = E_SYMBOL;
+				e->left.sym = &symbol_no;
+				e->right.expr = NULL;
+				return e;
+			} else if (e->right.expr->left.sym == &symbol_yes) {
+				free(e->right.expr);
+				tmp = e->left.expr;
+				*e = *(e->left.expr);
+				free(tmp);
+				return e;
+			}
+		}
+		break;
+	case E_OR:
+		e->left.expr = expr_eliminate_yn(e->left.expr);
+		e->right.expr = expr_eliminate_yn(e->right.expr);
+		if (e->left.expr->type == E_SYMBOL) {
+			if (e->left.expr->left.sym == &symbol_no) {
+				free(e->left.expr);
+				tmp = e->right.expr;
+				*e = *(e->right.expr);
+				free(tmp);
+				return e;
+			} else if (e->left.expr->left.sym == &symbol_yes) {
+				expr_free(e->left.expr);
+				expr_free(e->right.expr);
+				e->type = E_SYMBOL;
+				e->left.sym = &symbol_yes;
+				e->right.expr = NULL;
+				return e;
+			}
+		}
+		if (e->right.expr->type == E_SYMBOL) {
+			if (e->right.expr->left.sym == &symbol_no) {
+				free(e->right.expr);
+				tmp = e->left.expr;
+				*e = *(e->left.expr);
+				free(tmp);
+				return e;
+			} else if (e->right.expr->left.sym == &symbol_yes) {
+				expr_free(e->left.expr);
+				expr_free(e->right.expr);
+				e->type = E_SYMBOL;
+				e->left.sym = &symbol_yes;
+				e->right.expr = NULL;
+				return e;
+			}
+		}
+		break;
+	default:
+		;
+	}
+	return e;
+}
+
+/*
+ * bool FOO!=n => FOO
+ */
+struct expr *expr_trans_bool(struct expr *e)
+{
+	if (!e)
+		return NULL;
+	switch (e->type) {
+	case E_AND:
+	case E_OR:
+	case E_NOT:
+		e->left.expr = expr_trans_bool(e->left.expr);
+		e->right.expr = expr_trans_bool(e->right.expr);
+		break;
+	case E_UNEQUAL:
+		// FOO!=n -> FOO
+		if (e->left.sym->type == S_TRISTATE) {
+			if (e->right.sym == &symbol_no) {
+				e->type = E_SYMBOL;
+				e->right.sym = NULL;
+			}
+		}
+		break;
+	default:
+		;
+	}
+	return e;
+}
+
+/*
+ * e1 || e2 -> ?
+ */
+static struct expr *expr_join_or(struct expr *e1, struct expr *e2)
+{
+	struct expr *tmp;
+	struct symbol *sym1, *sym2;
+
+	if (expr_eq(e1, e2))
+		return expr_copy(e1);
+	if (e1->type != E_EQUAL && e1->type != E_UNEQUAL && e1->type != E_SYMBOL && e1->type != E_NOT)
+		return NULL;
+	if (e2->type != E_EQUAL && e2->type != E_UNEQUAL && e2->type != E_SYMBOL && e2->type != E_NOT)
+		return NULL;
+	if (e1->type == E_NOT) {
+		tmp = e1->left.expr;
+		if (tmp->type != E_EQUAL && tmp->type != E_UNEQUAL && tmp->type != E_SYMBOL)
+			return NULL;
+		sym1 = tmp->left.sym;
+	} else
+		sym1 = e1->left.sym;
+	if (e2->type == E_NOT) {
+		if (e2->left.expr->type != E_SYMBOL)
+			return NULL;
+		sym2 = e2->left.expr->left.sym;
+	} else
+		sym2 = e2->left.sym;
+	if (sym1 != sym2)
+		return NULL;
+	if (sym1->type != S_BOOLEAN && sym1->type != S_TRISTATE)
+		return NULL;
+	if (sym1->type == S_TRISTATE) {
+		if (e1->type == E_EQUAL && e2->type == E_EQUAL &&
+		    ((e1->right.sym == &symbol_yes && e2->right.sym == &symbol_mod) ||
+		     (e1->right.sym == &symbol_mod && e2->right.sym == &symbol_yes))) {
+			// (a='y') || (a='m') -> (a!='n')
+			return expr_alloc_comp(E_UNEQUAL, sym1, &symbol_no);
+		}
+		if (e1->type == E_EQUAL && e2->type == E_EQUAL &&
+		    ((e1->right.sym == &symbol_yes && e2->right.sym == &symbol_no) ||
+		     (e1->right.sym == &symbol_no && e2->right.sym == &symbol_yes))) {
+			// (a='y') || (a='n') -> (a!='m')
+			return expr_alloc_comp(E_UNEQUAL, sym1, &symbol_mod);
+		}
+		if (e1->type == E_EQUAL && e2->type == E_EQUAL &&
+		    ((e1->right.sym == &symbol_mod && e2->right.sym == &symbol_no) ||
+		     (e1->right.sym == &symbol_no && e2->right.sym == &symbol_mod))) {
+			// (a='m') || (a='n') -> (a!='y')
+			return expr_alloc_comp(E_UNEQUAL, sym1, &symbol_yes);
+		}
+	}
+	if (sym1->type == S_BOOLEAN && sym1 == sym2) {
+		if ((e1->type == E_NOT && e1->left.expr->type == E_SYMBOL && e2->type == E_SYMBOL) ||
+		    (e2->type == E_NOT && e2->left.expr->type == E_SYMBOL && e1->type == E_SYMBOL))
+			return expr_alloc_symbol(&symbol_yes);
+	}
+
+	if (DEBUG_EXPR) {
+		printf("optimize (");
+		expr_fprint(e1, stdout);
+		printf(") || (");
+		expr_fprint(e2, stdout);
+		printf(")?\n");
+	}
+	return NULL;
+}
+
+static struct expr *expr_join_and(struct expr *e1, struct expr *e2)
+{
+	struct expr *tmp;
+	struct symbol *sym1, *sym2;
+
+	if (expr_eq(e1, e2))
+		return expr_copy(e1);
+	if (e1->type != E_EQUAL && e1->type != E_UNEQUAL && e1->type != E_SYMBOL && e1->type != E_NOT)
+		return NULL;
+	if (e2->type != E_EQUAL && e2->type != E_UNEQUAL && e2->type != E_SYMBOL && e2->type != E_NOT)
+		return NULL;
+	if (e1->type == E_NOT) {
+		tmp = e1->left.expr;
+		if (tmp->type != E_EQUAL && tmp->type != E_UNEQUAL && tmp->type != E_SYMBOL)
+			return NULL;
+		sym1 = tmp->left.sym;
+	} else
+		sym1 = e1->left.sym;
+	if (e2->type == E_NOT) {
+		if (e2->left.expr->type != E_SYMBOL)
+			return NULL;
+		sym2 = e2->left.expr->left.sym;
+	} else
+		sym2 = e2->left.sym;
+	if (sym1 != sym2)
+		return NULL;
+	if (sym1->type != S_BOOLEAN && sym1->type != S_TRISTATE)
+		return NULL;
+
+	if ((e1->type == E_SYMBOL && e2->type == E_EQUAL && e2->right.sym == &symbol_yes) ||
+	    (e2->type == E_SYMBOL && e1->type == E_EQUAL && e1->right.sym == &symbol_yes))
+		// (a) && (a='y') -> (a='y')
+		return expr_alloc_comp(E_EQUAL, sym1, &symbol_yes);
+
+	if ((e1->type == E_SYMBOL && e2->type == E_UNEQUAL && e2->right.sym == &symbol_no) ||
+	    (e2->type == E_SYMBOL && e1->type == E_UNEQUAL && e1->right.sym == &symbol_no))
+		// (a) && (a!='n') -> (a)
+		return expr_alloc_symbol(sym1);
+
+	if ((e1->type == E_SYMBOL && e2->type == E_UNEQUAL && e2->right.sym == &symbol_mod) ||
+	    (e2->type == E_SYMBOL && e1->type == E_UNEQUAL && e1->right.sym == &symbol_mod))
+		// (a) && (a!='m') -> (a='y')
+		return expr_alloc_comp(E_EQUAL, sym1, &symbol_yes);
+
+	if (sym1->type == S_TRISTATE) {
+		if (e1->type == E_EQUAL && e2->type == E_UNEQUAL) {
+			// (a='b') && (a!='c') -> 'b'='c' ? 'n' : a='b'
+			sym2 = e1->right.sym;
+			if ((e2->right.sym->flags & SYMBOL_CONST) && (sym2->flags & SYMBOL_CONST))
+				return sym2 != e2->right.sym ? expr_alloc_comp(E_EQUAL, sym1, sym2)
+							     : expr_alloc_symbol(&symbol_no);
+		}
+		if (e1->type == E_UNEQUAL && e2->type == E_EQUAL) {
+			// (a='b') && (a!='c') -> 'b'='c' ? 'n' : a='b'
+			sym2 = e2->right.sym;
+			if ((e1->right.sym->flags & SYMBOL_CONST) && (sym2->flags & SYMBOL_CONST))
+				return sym2 != e1->right.sym ? expr_alloc_comp(E_EQUAL, sym1, sym2)
+							     : expr_alloc_symbol(&symbol_no);
+		}
+		if (e1->type == E_UNEQUAL && e2->type == E_UNEQUAL &&
+			   ((e1->right.sym == &symbol_yes && e2->right.sym == &symbol_no) ||
+			    (e1->right.sym == &symbol_no && e2->right.sym == &symbol_yes)))
+			// (a!='y') && (a!='n') -> (a='m')
+			return expr_alloc_comp(E_EQUAL, sym1, &symbol_mod);
+
+		if (e1->type == E_UNEQUAL && e2->type == E_UNEQUAL &&
+			   ((e1->right.sym == &symbol_yes && e2->right.sym == &symbol_mod) ||
+			    (e1->right.sym == &symbol_mod && e2->right.sym == &symbol_yes)))
+			// (a!='y') && (a!='m') -> (a='n')
+			return expr_alloc_comp(E_EQUAL, sym1, &symbol_no);
+
+		if (e1->type == E_UNEQUAL && e2->type == E_UNEQUAL &&
+			   ((e1->right.sym == &symbol_mod && e2->right.sym == &symbol_no) ||
+			    (e1->right.sym == &symbol_no && e2->right.sym == &symbol_mod)))
+			// (a!='m') && (a!='n') -> (a='m')
+			return expr_alloc_comp(E_EQUAL, sym1, &symbol_yes);
+
+		if ((e1->type == E_SYMBOL && e2->type == E_EQUAL && e2->right.sym == &symbol_mod) ||
+		    (e2->type == E_SYMBOL && e1->type == E_EQUAL && e1->right.sym == &symbol_mod) ||
+		    (e1->type == E_SYMBOL && e2->type == E_UNEQUAL && e2->right.sym == &symbol_yes) ||
+		    (e2->type == E_SYMBOL && e1->type == E_UNEQUAL && e1->right.sym == &symbol_yes))
+			return NULL;
+	}
+
+	if (DEBUG_EXPR) {
+		printf("optimize (");
+		expr_fprint(e1, stdout);
+		printf(") && (");
+		expr_fprint(e2, stdout);
+		printf(")?\n");
+	}
+	return NULL;
+}
+
+/*
+ * expr_eliminate_dups() helper.
+ *
+ * Walks the two expression trees given in 'ep1' and 'ep2'. Any node that does
+ * not have type 'type' (E_OR/E_AND) is considered a leaf, and is compared
+ * against all other leaves to look for simplifications.
+ */
+static void expr_eliminate_dups1(enum expr_type type, struct expr **ep1, struct expr **ep2)
+{
+#define e1 (*ep1)
+#define e2 (*ep2)
+	struct expr *tmp;
+
+	/* Recurse down to leaves */
+
+	if (e1->type == type) {
+		expr_eliminate_dups1(type, &e1->left.expr, &e2);
+		expr_eliminate_dups1(type, &e1->right.expr, &e2);
+		return;
+	}
+	if (e2->type == type) {
+		expr_eliminate_dups1(type, &e1, &e2->left.expr);
+		expr_eliminate_dups1(type, &e1, &e2->right.expr);
+		return;
+	}
+
+	/* e1 and e2 are leaves. Compare and process them. */
+
+	if (e1 == e2)
+		return;
+
+	switch (e1->type) {
+	case E_OR: case E_AND:
+		expr_eliminate_dups1(e1->type, &e1, &e1);
+	default:
+		;
+	}
+
+	switch (type) {
+	case E_OR:
+		tmp = expr_join_or(e1, e2);
+		if (tmp) {
+			expr_free(e1); expr_free(e2);
+			e1 = expr_alloc_symbol(&symbol_no);
+			e2 = tmp;
+			trans_count++;
+		}
+		break;
+	case E_AND:
+		tmp = expr_join_and(e1, e2);
+		if (tmp) {
+			expr_free(e1); expr_free(e2);
+			e1 = expr_alloc_symbol(&symbol_yes);
+			e2 = tmp;
+			trans_count++;
+		}
+		break;
+	default:
+		;
+	}
+#undef e1
+#undef e2
+}
+
+/*
+ * Rewrites 'e' in-place to remove ("join") duplicate and other redundant
+ * operands.
+ *
+ * Example simplifications:
+ *
+ *	A || B || A    ->  A || B
+ *	A && B && A=y  ->  A=y && B
+ *
+ * Returns the deduplicated expression.
+ */
+struct expr *expr_eliminate_dups(struct expr *e)
+{
+	int oldcount;
+	if (!e)
+		return e;
+
+	oldcount = trans_count;
+	while (1) {
+		trans_count = 0;
+		switch (e->type) {
+		case E_OR: case E_AND:
+			expr_eliminate_dups1(e->type, &e, &e);
+		default:
+			;
+		}
+		if (!trans_count)
+			/* No simplifications done in this pass. We're done */
+			break;
+		e = expr_eliminate_yn(e);
+	}
+	trans_count = oldcount;
+	return e;
+}
+
+/*
+ * Performs various simplifications involving logical operators and
+ * comparisons.
+ *
+ * Allocates and returns a new expression.
+ */
+struct expr *expr_transform(struct expr *e)
+{
+	struct expr *tmp;
+
+	if (!e)
+		return NULL;
+	switch (e->type) {
+	case E_EQUAL:
+	case E_GEQ:
+	case E_GTH:
+	case E_LEQ:
+	case E_LTH:
+	case E_UNEQUAL:
+	case E_SYMBOL:
+	case E_LIST:
+		break;
+	default:
+		e->left.expr = expr_transform(e->left.expr);
+		e->right.expr = expr_transform(e->right.expr);
+	}
+
+	switch (e->type) {
+	case E_EQUAL:
+		if (e->left.sym->type != S_BOOLEAN)
+			break;
+		if (e->right.sym == &symbol_no) {
+			e->type = E_NOT;
+			e->left.expr = expr_alloc_symbol(e->left.sym);
+			e->right.sym = NULL;
+			break;
+		}
+		if (e->right.sym == &symbol_mod) {
+			printf("boolean symbol %s tested for 'm'? test forced to 'n'\n", e->left.sym->name);
+			e->type = E_SYMBOL;
+			e->left.sym = &symbol_no;
+			e->right.sym = NULL;
+			break;
+		}
+		if (e->right.sym == &symbol_yes) {
+			e->type = E_SYMBOL;
+			e->right.sym = NULL;
+			break;
+		}
+		break;
+	case E_UNEQUAL:
+		if (e->left.sym->type != S_BOOLEAN)
+			break;
+		if (e->right.sym == &symbol_no) {
+			e->type = E_SYMBOL;
+			e->right.sym = NULL;
+			break;
+		}
+		if (e->right.sym == &symbol_mod) {
+			printf("boolean symbol %s tested for 'm'? test forced to 'y'\n", e->left.sym->name);
+			e->type = E_SYMBOL;
+			e->left.sym = &symbol_yes;
+			e->right.sym = NULL;
+			break;
+		}
+		if (e->right.sym == &symbol_yes) {
+			e->type = E_NOT;
+			e->left.expr = expr_alloc_symbol(e->left.sym);
+			e->right.sym = NULL;
+			break;
+		}
+		break;
+	case E_NOT:
+		switch (e->left.expr->type) {
+		case E_NOT:
+			// !!a -> a
+			tmp = e->left.expr->left.expr;
+			free(e->left.expr);
+			free(e);
+			e = tmp;
+			e = expr_transform(e);
+			break;
+		case E_EQUAL:
+		case E_UNEQUAL:
+			// !a='x' -> a!='x'
+			tmp = e->left.expr;
+			free(e);
+			e = tmp;
+			e->type = e->type == E_EQUAL ? E_UNEQUAL : E_EQUAL;
+			break;
+		case E_LEQ:
+		case E_GEQ:
+			// !a<='x' -> a>'x'
+			tmp = e->left.expr;
+			free(e);
+			e = tmp;
+			e->type = e->type == E_LEQ ? E_GTH : E_LTH;
+			break;
+		case E_LTH:
+		case E_GTH:
+			// !a<'x' -> a>='x'
+			tmp = e->left.expr;
+			free(e);
+			e = tmp;
+			e->type = e->type == E_LTH ? E_GEQ : E_LEQ;
+			break;
+		case E_OR:
+			// !(a || b) -> !a && !b
+			tmp = e->left.expr;
+			e->type = E_AND;
+			e->right.expr = expr_alloc_one(E_NOT, tmp->right.expr);
+			tmp->type = E_NOT;
+			tmp->right.expr = NULL;
+			e = expr_transform(e);
+			break;
+		case E_AND:
+			// !(a && b) -> !a || !b
+			tmp = e->left.expr;
+			e->type = E_OR;
+			e->right.expr = expr_alloc_one(E_NOT, tmp->right.expr);
+			tmp->type = E_NOT;
+			tmp->right.expr = NULL;
+			e = expr_transform(e);
+			break;
+		case E_SYMBOL:
+			if (e->left.expr->left.sym == &symbol_yes) {
+				// !'y' -> 'n'
+				tmp = e->left.expr;
+				free(e);
+				e = tmp;
+				e->type = E_SYMBOL;
+				e->left.sym = &symbol_no;
+				break;
+			}
+			if (e->left.expr->left.sym == &symbol_mod) {
+				// !'m' -> 'm'
+				tmp = e->left.expr;
+				free(e);
+				e = tmp;
+				e->type = E_SYMBOL;
+				e->left.sym = &symbol_mod;
+				break;
+			}
+			if (e->left.expr->left.sym == &symbol_no) {
+				// !'n' -> 'y'
+				tmp = e->left.expr;
+				free(e);
+				e = tmp;
+				e->type = E_SYMBOL;
+				e->left.sym = &symbol_yes;
+				break;
+			}
+			break;
+		default:
+			;
+		}
+		break;
+	default:
+		;
+	}
+	return e;
+}
+
+int expr_contains_symbol(struct expr *dep, struct symbol *sym)
+{
+	if (!dep)
+		return 0;
+
+	switch (dep->type) {
+	case E_AND:
+	case E_OR:
+		return expr_contains_symbol(dep->left.expr, sym) ||
+		       expr_contains_symbol(dep->right.expr, sym);
+	case E_SYMBOL:
+		return dep->left.sym == sym;
+	case E_EQUAL:
+	case E_GEQ:
+	case E_GTH:
+	case E_LEQ:
+	case E_LTH:
+	case E_UNEQUAL:
+		return dep->left.sym == sym ||
+		       dep->right.sym == sym;
+	case E_NOT:
+		return expr_contains_symbol(dep->left.expr, sym);
+	default:
+		;
+	}
+	return 0;
+}
+
+bool expr_depends_symbol(struct expr *dep, struct symbol *sym)
+{
+	if (!dep)
+		return false;
+
+	switch (dep->type) {
+	case E_AND:
+		return expr_depends_symbol(dep->left.expr, sym) ||
+		       expr_depends_symbol(dep->right.expr, sym);
+	case E_SYMBOL:
+		return dep->left.sym == sym;
+	case E_EQUAL:
+		if (dep->left.sym == sym) {
+			if (dep->right.sym == &symbol_yes || dep->right.sym == &symbol_mod)
+				return true;
+		}
+		break;
+	case E_UNEQUAL:
+		if (dep->left.sym == sym) {
+			if (dep->right.sym == &symbol_no)
+				return true;
+		}
+		break;
+	default:
+		;
+	}
+ 	return false;
+}
+
+/*
+ * Inserts explicit comparisons of type 'type' to symbol 'sym' into the
+ * expression 'e'.
+ *
+ * Examples transformations for type == E_UNEQUAL, sym == &symbol_no:
+ *
+ *	A              ->  A!=n
+ *	!A             ->  A=n
+ *	A && B         ->  !(A=n || B=n)
+ *	A || B         ->  !(A=n && B=n)
+ *	A && (B || C)  ->  !(A=n || (B=n && C=n))
+ *
+ * Allocates and returns a new expression.
+ */
+struct expr *expr_trans_compare(struct expr *e, enum expr_type type, struct symbol *sym)
+{
+	struct expr *e1, *e2;
+
+	if (!e) {
+		e = expr_alloc_symbol(sym);
+		if (type == E_UNEQUAL)
+			e = expr_alloc_one(E_NOT, e);
+		return e;
+	}
+	switch (e->type) {
+	case E_AND:
+		e1 = expr_trans_compare(e->left.expr, E_EQUAL, sym);
+		e2 = expr_trans_compare(e->right.expr, E_EQUAL, sym);
+		if (sym == &symbol_yes)
+			e = expr_alloc_two(E_AND, e1, e2);
+		if (sym == &symbol_no)
+			e = expr_alloc_two(E_OR, e1, e2);
+		if (type == E_UNEQUAL)
+			e = expr_alloc_one(E_NOT, e);
+		return e;
+	case E_OR:
+		e1 = expr_trans_compare(e->left.expr, E_EQUAL, sym);
+		e2 = expr_trans_compare(e->right.expr, E_EQUAL, sym);
+		if (sym == &symbol_yes)
+			e = expr_alloc_two(E_OR, e1, e2);
+		if (sym == &symbol_no)
+			e = expr_alloc_two(E_AND, e1, e2);
+		if (type == E_UNEQUAL)
+			e = expr_alloc_one(E_NOT, e);
+		return e;
+	case E_NOT:
+		return expr_trans_compare(e->left.expr, type == E_EQUAL ? E_UNEQUAL : E_EQUAL, sym);
+	case E_UNEQUAL:
+	case E_LTH:
+	case E_LEQ:
+	case E_GTH:
+	case E_GEQ:
+	case E_EQUAL:
+		if (type == E_EQUAL) {
+			if (sym == &symbol_yes)
+				return expr_copy(e);
+			if (sym == &symbol_mod)
+				return expr_alloc_symbol(&symbol_no);
+			if (sym == &symbol_no)
+				return expr_alloc_one(E_NOT, expr_copy(e));
+		} else {
+			if (sym == &symbol_yes)
+				return expr_alloc_one(E_NOT, expr_copy(e));
+			if (sym == &symbol_mod)
+				return expr_alloc_symbol(&symbol_yes);
+			if (sym == &symbol_no)
+				return expr_copy(e);
+		}
+		break;
+	case E_SYMBOL:
+		return expr_alloc_comp(type, e->left.sym, sym);
+	case E_LIST:
+	case E_RANGE:
+	case E_NONE:
+		/* panic */;
+	}
+	return NULL;
+}
+
+enum string_value_kind {
+	k_string,
+	k_signed,
+	k_unsigned,
+};
+
+union string_value {
+	unsigned long long u;
+	signed long long s;
+};
+
+static enum string_value_kind expr_parse_string(const char *str,
+						enum symbol_type type,
+						union string_value *val)
+{
+	char *tail;
+	enum string_value_kind kind;
+
+	errno = 0;
+	switch (type) {
+	case S_BOOLEAN:
+	case S_TRISTATE:
+		val->s = !strcmp(str, "n") ? 0 :
+			 !strcmp(str, "m") ? 1 :
+			 !strcmp(str, "y") ? 2 : -1;
+		return k_signed;
+	case S_INT:
+		val->s = strtoll(str, &tail, 10);
+		kind = k_signed;
+		break;
+	case S_HEX:
+		val->u = strtoull(str, &tail, 16);
+		kind = k_unsigned;
+		break;
+	default:
+		val->s = strtoll(str, &tail, 0);
+		kind = k_signed;
+		break;
+	}
+	return !errno && !*tail && tail > str && isxdigit(tail[-1])
+	       ? kind : k_string;
+}
+
+tristate expr_calc_value(struct expr *e)
+{
+	tristate val1, val2;
+	const char *str1, *str2;
+	enum string_value_kind k1 = k_string, k2 = k_string;
+	union string_value lval = {}, rval = {};
+	int res;
+
+	if (!e)
+		return yes;
+
+	switch (e->type) {
+	case E_SYMBOL:
+		sym_calc_value(e->left.sym);
+		return e->left.sym->curr.tri;
+	case E_AND:
+		val1 = expr_calc_value(e->left.expr);
+		val2 = expr_calc_value(e->right.expr);
+		return EXPR_AND(val1, val2);
+	case E_OR:
+		val1 = expr_calc_value(e->left.expr);
+		val2 = expr_calc_value(e->right.expr);
+		return EXPR_OR(val1, val2);
+	case E_NOT:
+		val1 = expr_calc_value(e->left.expr);
+		return EXPR_NOT(val1);
+	case E_EQUAL:
+	case E_GEQ:
+	case E_GTH:
+	case E_LEQ:
+	case E_LTH:
+	case E_UNEQUAL:
+		break;
+	default:
+		printf("expr_calc_value: %d?\n", e->type);
+		return no;
+	}
+
+	sym_calc_value(e->left.sym);
+	sym_calc_value(e->right.sym);
+	str1 = sym_get_string_value(e->left.sym);
+	str2 = sym_get_string_value(e->right.sym);
+
+	if (e->left.sym->type != S_STRING || e->right.sym->type != S_STRING) {
+		k1 = expr_parse_string(str1, e->left.sym->type, &lval);
+		k2 = expr_parse_string(str2, e->right.sym->type, &rval);
+	}
+
+	if (k1 == k_string || k2 == k_string)
+		res = strcmp(str1, str2);
+	else if (k1 == k_unsigned || k2 == k_unsigned)
+		res = (lval.u > rval.u) - (lval.u < rval.u);
+	else /* if (k1 == k_signed && k2 == k_signed) */
+		res = (lval.s > rval.s) - (lval.s < rval.s);
+
+	switch(e->type) {
+	case E_EQUAL:
+		return res ? no : yes;
+	case E_GEQ:
+		return res >= 0 ? yes : no;
+	case E_GTH:
+		return res > 0 ? yes : no;
+	case E_LEQ:
+		return res <= 0 ? yes : no;
+	case E_LTH:
+		return res < 0 ? yes : no;
+	case E_UNEQUAL:
+		return res ? yes : no;
+	default:
+		printf("expr_calc_value: relation %d?\n", e->type);
+		return no;
+	}
+}
+
+static int expr_compare_type(enum expr_type t1, enum expr_type t2)
+{
+	if (t1 == t2)
+		return 0;
+	switch (t1) {
+	case E_LEQ:
+	case E_LTH:
+	case E_GEQ:
+	case E_GTH:
+		if (t2 == E_EQUAL || t2 == E_UNEQUAL)
+			return 1;
+	case E_EQUAL:
+	case E_UNEQUAL:
+		if (t2 == E_NOT)
+			return 1;
+	case E_NOT:
+		if (t2 == E_AND)
+			return 1;
+	case E_AND:
+		if (t2 == E_OR)
+			return 1;
+	case E_OR:
+		if (t2 == E_LIST)
+			return 1;
+	case E_LIST:
+		if (t2 == 0)
+			return 1;
+	default:
+		return -1;
+	}
+	printf("[%dgt%d?]", t1, t2);
+	return 0;
+}
+
+void expr_print(struct expr *e,
+		void (*fn)(void *, struct symbol *, const char *),
+		void *data, int prevtoken)
+{
+	if (!e) {
+		fn(data, NULL, "y");
+		return;
+	}
+
+	if (expr_compare_type(prevtoken, e->type) > 0)
+		fn(data, NULL, "(");
+	switch (e->type) {
+	case E_SYMBOL:
+		if (e->left.sym->name)
+			fn(data, e->left.sym, e->left.sym->name);
+		else
+			fn(data, NULL, "<choice>");
+		break;
+	case E_NOT:
+		fn(data, NULL, "!");
+		expr_print(e->left.expr, fn, data, E_NOT);
+		break;
+	case E_EQUAL:
+		if (e->left.sym->name)
+			fn(data, e->left.sym, e->left.sym->name);
+		else
+			fn(data, NULL, "<choice>");
+		fn(data, NULL, "=");
+		fn(data, e->right.sym, e->right.sym->name);
+		break;
+	case E_LEQ:
+	case E_LTH:
+		if (e->left.sym->name)
+			fn(data, e->left.sym, e->left.sym->name);
+		else
+			fn(data, NULL, "<choice>");
+		fn(data, NULL, e->type == E_LEQ ? "<=" : "<");
+		fn(data, e->right.sym, e->right.sym->name);
+		break;
+	case E_GEQ:
+	case E_GTH:
+		if (e->left.sym->name)
+			fn(data, e->left.sym, e->left.sym->name);
+		else
+			fn(data, NULL, "<choice>");
+		fn(data, NULL, e->type == E_GEQ ? ">=" : ">");
+		fn(data, e->right.sym, e->right.sym->name);
+		break;
+	case E_UNEQUAL:
+		if (e->left.sym->name)
+			fn(data, e->left.sym, e->left.sym->name);
+		else
+			fn(data, NULL, "<choice>");
+		fn(data, NULL, "!=");
+		fn(data, e->right.sym, e->right.sym->name);
+		break;
+	case E_OR:
+		expr_print(e->left.expr, fn, data, E_OR);
+		fn(data, NULL, " || ");
+		expr_print(e->right.expr, fn, data, E_OR);
+		break;
+	case E_AND:
+		expr_print(e->left.expr, fn, data, E_AND);
+		fn(data, NULL, " && ");
+		expr_print(e->right.expr, fn, data, E_AND);
+		break;
+	case E_LIST:
+		fn(data, e->right.sym, e->right.sym->name);
+		if (e->left.expr) {
+			fn(data, NULL, " ^ ");
+			expr_print(e->left.expr, fn, data, E_LIST);
+		}
+		break;
+	case E_RANGE:
+		fn(data, NULL, "[");
+		fn(data, e->left.sym, e->left.sym->name);
+		fn(data, NULL, " ");
+		fn(data, e->right.sym, e->right.sym->name);
+		fn(data, NULL, "]");
+		break;
+	default:
+	  {
+		char buf[32];
+		sprintf(buf, "<unknown type %d>", e->type);
+		fn(data, NULL, buf);
+		break;
+	  }
+	}
+	if (expr_compare_type(prevtoken, e->type) > 0)
+		fn(data, NULL, ")");
+}
+
+static void expr_print_file_helper(void *data, struct symbol *sym, const char *str)
+{
+	xfwrite(str, strlen(str), 1, data);
+}
+
+void expr_fprint(struct expr *e, FILE *out)
+{
+	expr_print(e, expr_print_file_helper, out, E_NONE);
+}
+
+static void expr_print_gstr_helper(void *data, struct symbol *sym, const char *str)
+{
+	struct gstr *gs = (struct gstr*)data;
+	const char *sym_str = NULL;
+
+	if (sym)
+		sym_str = sym_get_string_value(sym);
+
+	if (gs->max_width) {
+		unsigned extra_length = strlen(str);
+		const char *last_cr = strrchr(gs->s, '\n');
+		unsigned last_line_length;
+
+		if (sym_str)
+			extra_length += 4 + strlen(sym_str);
+
+		if (!last_cr)
+			last_cr = gs->s;
+
+		last_line_length = strlen(gs->s) - (last_cr - gs->s);
+
+		if ((last_line_length + extra_length) > gs->max_width)
+			str_append(gs, "\\\n");
+	}
+
+	str_append(gs, str);
+	if (sym && sym->type != S_UNKNOWN)
+		str_printf(gs, " [=%s]", sym_str);
+}
+
+void expr_gstr_print(struct expr *e, struct gstr *gs)
+{
+	expr_print(e, expr_print_gstr_helper, gs, E_NONE);
+}
+
+/*
+ * Transform the top level "||" tokens into newlines and prepend each
+ * line with a minus. This makes expressions much easier to read.
+ * Suitable for reverse dependency expressions.
+ */
+static void expr_print_revdep(struct expr *e,
+			      void (*fn)(void *, struct symbol *, const char *),
+			      void *data, tristate pr_type, const char **title)
+{
+	if (e->type == E_OR) {
+		expr_print_revdep(e->left.expr, fn, data, pr_type, title);
+		expr_print_revdep(e->right.expr, fn, data, pr_type, title);
+	} else if (expr_calc_value(e) == pr_type) {
+		if (*title) {
+			fn(data, NULL, *title);
+			*title = NULL;
+		}
+
+		fn(data, NULL, "  - ");
+		expr_print(e, fn, data, E_NONE);
+		fn(data, NULL, "\n");
+	}
+}
+
+void expr_gstr_print_revdep(struct expr *e, struct gstr *gs,
+			    tristate pr_type, const char *title)
+{
+	expr_print_revdep(e, expr_print_gstr_helper, gs, pr_type, &title);
+}
diff --git a/backport/kconf/expr.h b/backport/kconf/expr.h
new file mode 100644
index 000000000000..9c9caca5bd5f
--- /dev/null
+++ b/backport/kconf/expr.h
@@ -0,0 +1,326 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (C) 2002 Roman Zippel <zippel@linux-m68k.org>
+ */
+
+#ifndef EXPR_H
+#define EXPR_H
+
+#ifdef __cplusplus
+extern "C" {
+#endif
+
+#include <assert.h>
+#include <stdio.h>
+#include "list.h"
+#ifndef __cplusplus
+#include <stdbool.h>
+#endif
+
+struct file {
+	struct file *next;
+	struct file *parent;
+	const char *name;
+	int lineno;
+};
+
+typedef enum tristate {
+	no, mod, yes
+} tristate;
+
+enum expr_type {
+	E_NONE, E_OR, E_AND, E_NOT,
+	E_EQUAL, E_UNEQUAL, E_LTH, E_LEQ, E_GTH, E_GEQ,
+	E_LIST, E_SYMBOL, E_RANGE
+};
+
+union expr_data {
+	struct expr *expr;
+	struct symbol *sym;
+};
+
+struct expr {
+	enum expr_type type;
+	union expr_data left, right;
+};
+
+#define EXPR_OR(dep1, dep2)	(((dep1)>(dep2))?(dep1):(dep2))
+#define EXPR_AND(dep1, dep2)	(((dep1)<(dep2))?(dep1):(dep2))
+#define EXPR_NOT(dep)		(2-(dep))
+
+#define expr_list_for_each_sym(l, e, s) \
+	for (e = (l); e && (s = e->right.sym); e = e->left.expr)
+
+struct expr_value {
+	struct expr *expr;
+	tristate tri;
+};
+
+struct symbol_value {
+	void *val;
+	tristate tri;
+};
+
+enum symbol_type {
+	S_UNKNOWN, S_BOOLEAN, S_TRISTATE, S_INT, S_HEX, S_STRING
+};
+
+/* enum values are used as index to symbol.def[] */
+enum {
+	S_DEF_USER,		/* main user value */
+	S_DEF_AUTO,		/* values read from auto.conf */
+	S_DEF_DEF3,		/* Reserved for UI usage */
+	S_DEF_DEF4,		/* Reserved for UI usage */
+	S_DEF_COUNT
+};
+
+/*
+ * Represents a configuration symbol.
+ *
+ * Choices are represented as a special kind of symbol and have the
+ * SYMBOL_CHOICE bit set in 'flags'.
+ */
+struct symbol {
+	/* The next symbol in the same bucket in the symbol hash table */
+	struct symbol *next;
+
+	/* The name of the symbol, e.g. "FOO" for 'config FOO' */
+	char *name;
+
+	/* S_BOOLEAN, S_TRISTATE, ... */
+	enum symbol_type type;
+
+	/*
+	 * The calculated value of the symbol. The SYMBOL_VALID bit is set in
+	 * 'flags' when this is up to date. Note that this value might differ
+	 * from the user value set in e.g. a .config file, due to visibility.
+	 */
+	struct symbol_value curr;
+
+	/*
+	 * Values for the symbol provided from outside. def[S_DEF_USER] holds
+	 * the .config value.
+	 */
+	struct symbol_value def[S_DEF_COUNT];
+
+	/*
+	 * An upper bound on the tristate value the user can set for the symbol
+	 * if it is a boolean or tristate. Calculated from prompt dependencies,
+	 * which also inherit dependencies from enclosing menus, choices, and
+	 * ifs. If 'n', the user value will be ignored.
+	 *
+	 * Symbols lacking prompts always have visibility 'n'.
+	 */
+	tristate visible;
+
+	/* SYMBOL_* flags */
+	int flags;
+
+	/* List of properties. See prop_type. */
+	struct property *prop;
+
+	/* Dependencies from enclosing menus, choices, and ifs */
+	struct expr_value dir_dep;
+
+	/* Reverse dependencies through being selected by other symbols */
+	struct expr_value rev_dep;
+
+	/*
+	 * "Weak" reverse dependencies through being implied by other symbols
+	 */
+	struct expr_value implied;
+};
+
+#define for_all_symbols(i, sym) for (i = 0; i < SYMBOL_HASHSIZE; i++) for (sym = symbol_hash[i]; sym; sym = sym->next)
+
+#define SYMBOL_CONST      0x0001  /* symbol is const */
+#define SYMBOL_CHECK      0x0008  /* used during dependency checking */
+#define SYMBOL_CHOICE     0x0010  /* start of a choice block (null name) */
+#define SYMBOL_CHOICEVAL  0x0020  /* used as a value in a choice block */
+#define SYMBOL_VALID      0x0080  /* set when symbol.curr is calculated */
+#define SYMBOL_OPTIONAL   0x0100  /* choice is optional - values can be 'n' */
+#define SYMBOL_WRITE      0x0200  /* write symbol to file (KCONFIG_CONFIG) */
+#define SYMBOL_CHANGED    0x0400  /* ? */
+#define SYMBOL_WRITTEN    0x0800  /* track info to avoid double-write to .config */
+#define SYMBOL_NO_WRITE   0x1000  /* Symbol for internal use only; it will not be written */
+#define SYMBOL_CHECKED    0x2000  /* used during dependency checking */
+#define SYMBOL_WARNED     0x8000  /* warning has been issued */
+
+/* Set when symbol.def[] is used */
+#define SYMBOL_DEF        0x10000  /* First bit of SYMBOL_DEF */
+#define SYMBOL_DEF_USER   0x10000  /* symbol.def[S_DEF_USER] is valid */
+#define SYMBOL_DEF_AUTO   0x20000  /* symbol.def[S_DEF_AUTO] is valid */
+#define SYMBOL_DEF3       0x40000  /* symbol.def[S_DEF_3] is valid */
+#define SYMBOL_DEF4       0x80000  /* symbol.def[S_DEF_4] is valid */
+
+/* choice values need to be set before calculating this symbol value */
+#define SYMBOL_NEED_SET_CHOICE_VALUES  0x100000
+
+#define SYMBOL_MAXLENGTH	256
+#define SYMBOL_HASHSIZE		9973
+
+/* A property represent the config options that can be associated
+ * with a config "symbol".
+ * Sample:
+ * config FOO
+ *         default y
+ *         prompt "foo prompt"
+ *         select BAR
+ * config BAZ
+ *         int "BAZ Value"
+ *         range 1..255
+ *
+ * Please, also check parser.y:print_symbol() when modifying the
+ * list of property types!
+ */
+enum prop_type {
+	P_UNKNOWN,
+	P_PROMPT,   /* prompt "foo prompt" or "BAZ Value" */
+	P_COMMENT,  /* text associated with a comment */
+	P_MENU,     /* prompt associated with a menu or menuconfig symbol */
+	P_DEFAULT,  /* default y */
+	P_CHOICE,   /* choice value */
+	P_SELECT,   /* select BAR */
+	P_IMPLY,    /* imply BAR */
+	P_RANGE,    /* range 7..100 (for a symbol) */
+	P_SYMBOL,   /* where a symbol is defined */
+};
+
+struct property {
+	struct property *next;     /* next property - null if last */
+	enum prop_type type;       /* type of property */
+	const char *text;          /* the prompt value - P_PROMPT, P_MENU, P_COMMENT */
+	struct expr_value visible;
+	struct expr *expr;         /* the optional conditional part of the property */
+	struct menu *menu;         /* the menu the property are associated with
+	                            * valid for: P_SELECT, P_RANGE, P_CHOICE,
+	                            * P_PROMPT, P_DEFAULT, P_MENU, P_COMMENT */
+	struct file *file;         /* what file was this property defined */
+	int lineno;                /* what lineno was this property defined */
+};
+
+#define for_all_properties(sym, st, tok) \
+	for (st = sym->prop; st; st = st->next) \
+		if (st->type == (tok))
+#define for_all_defaults(sym, st) for_all_properties(sym, st, P_DEFAULT)
+#define for_all_choices(sym, st) for_all_properties(sym, st, P_CHOICE)
+#define for_all_prompts(sym, st) \
+	for (st = sym->prop; st; st = st->next) \
+		if (st->text)
+
+/*
+ * Represents a node in the menu tree, as seen in e.g. menuconfig (though used
+ * for all front ends). Each symbol, menu, etc. defined in the Kconfig files
+ * gets a node. A symbol defined in multiple locations gets one node at each
+ * location.
+ */
+struct menu {
+	/* The next menu node at the same level */
+	struct menu *next;
+
+	/* The parent menu node, corresponding to e.g. a menu or choice */
+	struct menu *parent;
+
+	/* The first child menu node, for e.g. menus and choices */
+	struct menu *list;
+
+	/*
+	 * The symbol associated with the menu node. Choices are implemented as
+	 * a special kind of symbol. NULL for menus, comments, and ifs.
+	 */
+	struct symbol *sym;
+
+	/*
+	 * The prompt associated with the node. This holds the prompt for a
+	 * symbol as well as the text for a menu or comment, along with the
+	 * type (P_PROMPT, P_MENU, etc.)
+	 */
+	struct property *prompt;
+
+	/*
+	 * 'visible if' dependencies. If more than one is given, they will be
+	 * ANDed together.
+	 */
+	struct expr *visibility;
+
+	/*
+	 * Ordinary dependencies from e.g. 'depends on' and 'if', ANDed
+	 * together
+	 */
+	struct expr *dep;
+
+	/* MENU_* flags */
+	unsigned int flags;
+
+	/* Any help text associated with the node */
+	char *help;
+
+	/* The location where the menu node appears in the Kconfig files */
+	struct file *file;
+	int lineno;
+
+	/* For use by front ends that need to store auxiliary data */
+	void *data;
+};
+
+/*
+ * Set on a menu node when the corresponding symbol changes state in some way.
+ * Can be checked by front ends.
+ */
+#define MENU_CHANGED		0x0001
+
+#define MENU_ROOT		0x0002
+
+struct jump_key {
+	struct list_head entries;
+	size_t offset;
+	struct menu *target;
+	int index;
+};
+
+extern struct file *file_list;
+extern struct file *current_file;
+struct file *lookup_file(const char *name);
+
+extern struct symbol symbol_yes, symbol_no, symbol_mod;
+extern struct symbol *modules_sym;
+extern int cdebug;
+struct expr *expr_alloc_symbol(struct symbol *sym);
+struct expr *expr_alloc_one(enum expr_type type, struct expr *ce);
+struct expr *expr_alloc_two(enum expr_type type, struct expr *e1, struct expr *e2);
+struct expr *expr_alloc_comp(enum expr_type type, struct symbol *s1, struct symbol *s2);
+struct expr *expr_alloc_and(struct expr *e1, struct expr *e2);
+struct expr *expr_alloc_or(struct expr *e1, struct expr *e2);
+struct expr *expr_copy(const struct expr *org);
+void expr_free(struct expr *e);
+void expr_eliminate_eq(struct expr **ep1, struct expr **ep2);
+int expr_eq(struct expr *e1, struct expr *e2);
+tristate expr_calc_value(struct expr *e);
+struct expr *expr_trans_bool(struct expr *e);
+struct expr *expr_eliminate_dups(struct expr *e);
+struct expr *expr_transform(struct expr *e);
+int expr_contains_symbol(struct expr *dep, struct symbol *sym);
+bool expr_depends_symbol(struct expr *dep, struct symbol *sym);
+struct expr *expr_trans_compare(struct expr *e, enum expr_type type, struct symbol *sym);
+
+void expr_fprint(struct expr *e, FILE *out);
+struct gstr; /* forward */
+void expr_gstr_print(struct expr *e, struct gstr *gs);
+void expr_gstr_print_revdep(struct expr *e, struct gstr *gs,
+			    tristate pr_type, const char *title);
+
+static inline int expr_is_yes(struct expr *e)
+{
+	return !e || (e->type == E_SYMBOL && e->left.sym == &symbol_yes);
+}
+
+static inline int expr_is_no(struct expr *e)
+{
+	return e && (e->type == E_SYMBOL && e->left.sym == &symbol_no);
+}
+
+#ifdef __cplusplus
+}
+#endif
+
+#endif /* EXPR_H */
diff --git a/backport/kconf/internal.h b/backport/kconf/internal.h
new file mode 100644
index 000000000000..2f7298c21b64
--- /dev/null
+++ b/backport/kconf/internal.h
@@ -0,0 +1,9 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+#ifndef INTERNAL_H
+#define INTERNAL_H
+
+struct menu;
+
+extern struct menu *current_menu, *current_entry;
+
+#endif /* INTERNAL_H */
diff --git a/backport/kconf/kconf_id.c b/backport/kconf/kconf_id.c
new file mode 100644
index 000000000000..b3e0ea0ac732
--- /dev/null
+++ b/backport/kconf/kconf_id.c
@@ -0,0 +1,52 @@
+
+static struct kconf_id kconf_id_array[] = {
+	{ "mainmenu",		T_MAINMENU,		TF_COMMAND },
+	{ "menu",		T_MENU,			TF_COMMAND },
+	{ "endmenu",		T_ENDMENU,		TF_COMMAND },
+	{ "source",		T_SOURCE,		TF_COMMAND },
+	{ "choice",		T_CHOICE,		TF_COMMAND },
+	{ "endchoice",		T_ENDCHOICE,		TF_COMMAND },
+	{ "comment",		T_COMMENT,		TF_COMMAND },
+	{ "config",		T_CONFIG,		TF_COMMAND },
+	{ "menuconfig",		T_MENUCONFIG,		TF_COMMAND },
+	{ "help",		T_HELP,			TF_COMMAND },
+	{ "---help---",		T_HELP,			TF_COMMAND },
+	{ "if",			T_IF,			TF_COMMAND|TF_PARAM },
+	{ "endif",		T_ENDIF,		TF_COMMAND },
+	{ "depends",		T_DEPENDS,		TF_COMMAND },
+	{ "optional",		T_OPTIONAL,		TF_COMMAND },
+	{ "default",		T_DEFAULT,		TF_COMMAND, S_UNKNOWN },
+	{ "prompt",		T_PROMPT,		TF_COMMAND },
+	{ "tristate",		T_TYPE,			TF_COMMAND, S_TRISTATE },
+	{ "def_tristate",	T_DEFAULT,		TF_COMMAND, S_TRISTATE },
+	{ "bool",		T_TYPE,			TF_COMMAND, S_BOOLEAN },
+	{ "def_bool",		T_DEFAULT,		TF_COMMAND, S_BOOLEAN },
+	{ "int",		T_TYPE,			TF_COMMAND, S_INT },
+	{ "hex",		T_TYPE,			TF_COMMAND, S_HEX },
+	{ "string",		T_TYPE,			TF_COMMAND, S_STRING },
+	{ "select",		T_SELECT,		TF_COMMAND },
+	{ "imply",		T_IMPLY,		TF_COMMAND },
+	{ "range",		T_RANGE,		TF_COMMAND },
+	{ "visible",		T_VISIBLE,		TF_COMMAND },
+	{ "option",		T_OPTION,		TF_COMMAND },
+	{ "on",			T_ON,			TF_PARAM },
+	{ "modules",		T_OPT_MODULES,		TF_OPTION },
+	{ "defconfig_list",	T_OPT_DEFCONFIG_LIST,	TF_OPTION },
+	{ "allnoconfig_y",	T_OPT_ALLNOCONFIG_Y,	TF_OPTION },
+};
+
+#define KCONF_ID_ARRAY_SIZE (sizeof(kconf_id_array)/sizeof(struct kconf_id))
+
+static const struct kconf_id *kconf_id_lookup(register const char *str, register unsigned int len)
+{
+	int i;
+
+	for (i = 0; i < KCONF_ID_ARRAY_SIZE; i++) {
+		struct kconf_id *id = kconf_id_array+i;
+		int l = strlen(id->name);
+
+		if (len == l && !memcmp(str, id->name, len))
+			return id;
+	}
+	return NULL;
+}
diff --git a/backport/kconf/kconfig.Makefile b/backport/kconf/kconfig.Makefile
new file mode 100644
index 000000000000..1b5f05f6b4b0
--- /dev/null
+++ b/backport/kconf/kconfig.Makefile
@@ -0,0 +1,65 @@
+# SPDX-License-Identifier: GPL-2.0
+#
+# Generic Makefile for userspace kconfig integration / generic simple
+# obj-y build helpers.
+
+# Bring in all the options selected
+#
+# Using optional include with -include will still try to process our .config
+# target, and we don't want that unless the user manually specified that or
+# its part of a dependency chain listing. To do this we have to avoid doing
+# the optional include unless it actually exists, so we re-invent an optional
+# include which doesn't get used unless actually used as a target.
+ifeq (,$(wildcard $(CURDIR)/.config))
+else
+include .config
+endif
+
+# Kconfig filechk magic helper
+include $(KCONFIG_DIR)/Kbuild.include
+
+PROJECTVERSION = $(VERSION)$(if $(PATCHLEVEL),.$(PATCHLEVEL)$(if $(SUBLEVEL),.$(SUBLEVEL)))$(EXTRAVERSION)
+# Picks up the project version and appends it with any dirty information in
+# case were have modified our tree.
+PROJECTRELEASE = $(shell test -f $(CURDIR)/include/config/project.release && cat $(CURDIR)/include/config/project.release 2> /dev/null)
+
+define filechk_project.release
+	echo "$(PROJECTVERSION)$$($(KCONFIG_DIR)/setlocalversion $(CURDIR))"
+endef
+
+include/config/project.release: $(CURDIR)/Makefile
+	@$(call filechk,project.release)
+
+export PROJECT PROJECTVERSION PROJECTRELEASE
+
+$(KCONFIG_DIR)/mconf:
+	$(MAKE) -C $(KCONFIG_DIR)/ .mconf-cfg
+	$(MAKE) -C $(KCONFIG_DIR)/ mconf
+
+PHONY += menuconfig
+menuconfig: $(KCONFIG_DIR)/mconf include/config/project.release
+	@$< Kconfig
+
+$(KCONFIG_DIR)/nconf:
+	$(MAKE) -C $(KCONFIG_DIR)/ .nconf-cfg
+	$(MAKE) -C $(KCONFIG_DIR)/ nconf
+
+PHONY += nconfig
+nconfig: $(KCONFIG_DIR)/nconf include/config/project.release
+	@$< Kconfig
+
+$(KCONFIG_DIR)/conf:
+	$(MAKE) -C $(KCONFIG_DIR) conf
+
+# More are supported, however we only list the ones tested on this top
+# level Makefile.
+simple-targets := allnoconfig allyesconfig alldefconfig randconfig
+PHONY += $(simple-targets)
+
+$(simple-targets): $(KCONFIG_DIR)/conf
+	$< --$@ Kconfig
+
+defconfig-%:: $(KCONFIG_DIR)/conf
+	@$< --defconfig=defconfigs/$(@:defconfig-%=%) Kconfig
+
+.PHONY: $(PHONY)
diff --git a/backport/kconf/kconfig/.gitignore b/backport/kconf/kconfig/.gitignore
new file mode 100644
index 000000000000..4adcb5a5fb6c
--- /dev/null
+++ b/backport/kconf/kconfig/.gitignore
@@ -0,0 +1,16 @@
+#
+# Generated files
+#
+*.moc
+*.lex.c
+
+#
+# configuration programs
+#
+conf
+mconf
+nconf
+qconf
+gconf
+
+zconf.tab.c
diff --git a/backport/kconf/lexer.l b/backport/kconf/lexer.l
new file mode 100644
index 000000000000..cc386e443683
--- /dev/null
+++ b/backport/kconf/lexer.l
@@ -0,0 +1,468 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (C) 2002 Roman Zippel <zippel@linux-m68k.org>
+ */
+%option nostdinit noyywrap never-interactive full ecs
+%option 8bit nodefault yylineno
+%x ASSIGN_VAL HELP STRING
+%{
+
+#include <assert.h>
+#include <limits.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+
+#include "lkc.h"
+#include "parser.tab.h"
+
+#define YY_DECL		static int yylex1(void)
+
+#define START_STRSIZE	16
+
+static struct {
+	struct file *file;
+	int lineno;
+} current_pos;
+
+static int prev_prev_token = T_EOL;
+static int prev_token = T_EOL;
+static char *text;
+static int text_size, text_asize;
+
+struct buffer {
+	struct buffer *parent;
+	YY_BUFFER_STATE state;
+};
+
+static struct buffer *current_buf;
+
+static int last_ts, first_ts;
+
+static char *expand_token(const char *in, size_t n);
+static void append_expanded_string(const char *in);
+static void zconf_endhelp(void);
+static void zconf_endfile(void);
+
+static void new_string(void)
+{
+	text = xmalloc(START_STRSIZE);
+	text_asize = START_STRSIZE;
+	text_size = 0;
+	*text = 0;
+}
+
+static void append_string(const char *str, int size)
+{
+	int new_size = text_size + size + 1;
+	if (new_size > text_asize) {
+		new_size += START_STRSIZE - 1;
+		new_size &= -START_STRSIZE;
+		text = xrealloc(text, new_size);
+		text_asize = new_size;
+	}
+	memcpy(text + text_size, str, size);
+	text_size += size;
+	text[text_size] = 0;
+}
+
+static void alloc_string(const char *str, int size)
+{
+	text = xmalloc(size + 1);
+	memcpy(text, str, size);
+	text[size] = 0;
+}
+
+static void warn_ignored_character(char chr)
+{
+	fprintf(stderr,
+	        "%s:%d:warning: ignoring unsupported character '%c'\n",
+	        current_file->name, yylineno, chr);
+}
+%}
+
+n	[A-Za-z0-9_-]
+
+%%
+	char open_quote = 0;
+
+#.*			/* ignore comment */
+[ \t]*			/* whitespaces */
+\\\n			/* escaped new line */
+\n			return T_EOL;
+"bool"			return T_BOOL;
+"choice"		return T_CHOICE;
+"comment"		return T_COMMENT;
+"config"		return T_CONFIG;
+"def_bool"		return T_DEF_BOOL;
+"def_tristate"		return T_DEF_TRISTATE;
+"default"		return T_DEFAULT;
+"depends"		return T_DEPENDS;
+"endchoice"		return T_ENDCHOICE;
+"endif"			return T_ENDIF;
+"endmenu"		return T_ENDMENU;
+"help"			return T_HELP;
+"hex"			return T_HEX;
+"if"			return T_IF;
+"imply"			return T_IMPLY;
+"int"			return T_INT;
+"mainmenu"		return T_MAINMENU;
+"menu"			return T_MENU;
+"menuconfig"		return T_MENUCONFIG;
+"modules"		return T_MODULES;
+"on"			return T_ON;
+"optional"		return T_OPTIONAL;
+"prompt"		return T_PROMPT;
+"range"			return T_RANGE;
+"select"		return T_SELECT;
+"source"		return T_SOURCE;
+"string"		return T_STRING;
+"tristate"		return T_TRISTATE;
+"visible"		return T_VISIBLE;
+"||"			return T_OR;
+"&&"			return T_AND;
+"="			return T_EQUAL;
+"!="			return T_UNEQUAL;
+"<"			return T_LESS;
+"<="			return T_LESS_EQUAL;
+">"			return T_GREATER;
+">="			return T_GREATER_EQUAL;
+"!"			return T_NOT;
+"("			return T_OPEN_PAREN;
+")"			return T_CLOSE_PAREN;
+":="			return T_COLON_EQUAL;
+"+="			return T_PLUS_EQUAL;
+\"|\'			{
+				open_quote = yytext[0];
+				new_string();
+				BEGIN(STRING);
+			}
+{n}+			{
+				alloc_string(yytext, yyleng);
+				yylval.string = text;
+				return T_WORD;
+			}
+({n}|$)+		{
+				/* this token includes at least one '$' */
+				yylval.string = expand_token(yytext, yyleng);
+				if (strlen(yylval.string))
+					return T_WORD;
+				free(yylval.string);
+			}
+.			warn_ignored_character(*yytext);
+
+<ASSIGN_VAL>{
+	[^[:blank:]\n]+.*	{
+		alloc_string(yytext, yyleng);
+		yylval.string = text;
+		return T_ASSIGN_VAL;
+	}
+	\n	{ BEGIN(INITIAL); return T_EOL; }
+	.
+}
+
+<STRING>{
+	"$".*	append_expanded_string(yytext);
+	[^$'"\\\n]+	{
+		append_string(yytext, yyleng);
+	}
+	\\.?	{
+		append_string(yytext + 1, yyleng - 1);
+	}
+	\'|\"	{
+		if (open_quote == yytext[0]) {
+			BEGIN(INITIAL);
+			yylval.string = text;
+			return T_WORD_QUOTE;
+		} else
+			append_string(yytext, 1);
+	}
+	\n	{
+		fprintf(stderr,
+			"%s:%d:warning: multi-line strings not supported\n",
+			zconf_curname(), zconf_lineno());
+		unput('\n');
+		BEGIN(INITIAL);
+		yylval.string = text;
+		return T_WORD_QUOTE;
+	}
+	<<EOF>>	{
+		BEGIN(INITIAL);
+		yylval.string = text;
+		return T_WORD_QUOTE;
+	}
+}
+
+<HELP>{
+	[ \t]+	{
+		int ts, i;
+
+		ts = 0;
+		for (i = 0; i < yyleng; i++) {
+			if (yytext[i] == '\t')
+				ts = (ts & ~7) + 8;
+			else
+				ts++;
+		}
+		last_ts = ts;
+		if (first_ts) {
+			if (ts < first_ts) {
+				zconf_endhelp();
+				return T_HELPTEXT;
+			}
+			ts -= first_ts;
+			while (ts > 8) {
+				append_string("        ", 8);
+				ts -= 8;
+			}
+			append_string("        ", ts);
+		}
+	}
+	[ \t]*\n/[^ \t\n] {
+		zconf_endhelp();
+		return T_HELPTEXT;
+	}
+	[ \t]*\n	{
+		append_string("\n", 1);
+	}
+	[^ \t\n].* {
+		while (yyleng) {
+			if ((yytext[yyleng-1] != ' ') && (yytext[yyleng-1] != '\t'))
+				break;
+			yyleng--;
+		}
+		append_string(yytext, yyleng);
+		if (!first_ts)
+			first_ts = last_ts;
+	}
+	<<EOF>>	{
+		zconf_endhelp();
+		return T_HELPTEXT;
+	}
+}
+
+<<EOF>>	{
+	BEGIN(INITIAL);
+
+	if (prev_token != T_EOL && prev_token != T_HELPTEXT)
+		fprintf(stderr, "%s:%d:warning: no new line at end of file\n",
+			current_file->name, yylineno);
+
+	if (current_file) {
+		zconf_endfile();
+		return T_EOL;
+	}
+	fclose(yyin);
+	yyterminate();
+}
+
+%%
+
+/* second stage lexer */
+int yylex(void)
+{
+	int token;
+
+repeat:
+	token = yylex1();
+
+	if (prev_token == T_EOL || prev_token == T_HELPTEXT) {
+		if (token == T_EOL) {
+			/* Do not pass unneeded T_EOL to the parser. */
+			goto repeat;
+		} else {
+			/*
+			 * For the parser, update file/lineno at the first token
+			 * of each statement. Generally, \n is a statement
+			 * terminator in Kconfig, but it is not always true
+			 * because \n could be escaped by a backslash.
+			 */
+			current_pos.file = current_file;
+			current_pos.lineno = yylineno;
+		}
+	}
+
+	if (prev_prev_token == T_EOL && prev_token == T_WORD &&
+	    (token == T_EQUAL || token == T_COLON_EQUAL || token == T_PLUS_EQUAL))
+		BEGIN(ASSIGN_VAL);
+
+	prev_prev_token = prev_token;
+	prev_token = token;
+
+	return token;
+}
+
+static char *expand_token(const char *in, size_t n)
+{
+	char *out;
+	int c;
+	char c2;
+	const char *rest, *end;
+
+	new_string();
+	append_string(in, n);
+
+	/* get the whole line because we do not know the end of token. */
+	while ((c = input()) != EOF) {
+		if (c == '\n') {
+			unput(c);
+			break;
+		}
+		c2 = c;
+		append_string(&c2, 1);
+	}
+
+	rest = text;
+	out = expand_one_token(&rest);
+
+	/* push back unused characters to the input stream */
+	end = rest + strlen(rest);
+	while (end > rest)
+		unput(*--end);
+
+	free(text);
+
+	return out;
+}
+
+static void append_expanded_string(const char *str)
+{
+	const char *end;
+	char *res;
+
+	str++;
+
+	res = expand_dollar(&str);
+
+	/* push back unused characters to the input stream */
+	end = str + strlen(str);
+	while (end > str)
+		unput(*--end);
+
+	append_string(res, strlen(res));
+
+	free(res);
+}
+
+void zconf_starthelp(void)
+{
+	new_string();
+	last_ts = first_ts = 0;
+	BEGIN(HELP);
+}
+
+static void zconf_endhelp(void)
+{
+	yylval.string = text;
+	BEGIN(INITIAL);
+}
+
+
+/*
+ * Try to open specified file with following names:
+ * ./name
+ * $(srctree)/name
+ * The latter is used when srctree is separate from objtree
+ * when compiling the kernel.
+ * Return NULL if file is not found.
+ */
+FILE *zconf_fopen(const char *name)
+{
+	char *env, fullname[PATH_MAX+1];
+	FILE *f;
+
+	f = fopen(name, "r");
+	if (!f && name != NULL && name[0] != '/') {
+		env = getenv(SRCTREE);
+		if (env) {
+			snprintf(fullname, sizeof(fullname),
+				 "%s/%s", env, name);
+			f = fopen(fullname, "r");
+		}
+	}
+	return f;
+}
+
+void zconf_initscan(const char *name)
+{
+	yyin = zconf_fopen(name);
+	if (!yyin) {
+		fprintf(stderr, "can't find file %s\n", name);
+		exit(1);
+	}
+
+	current_buf = xmalloc(sizeof(*current_buf));
+	memset(current_buf, 0, sizeof(*current_buf));
+
+	current_file = file_lookup(name);
+	yylineno = 1;
+}
+
+void zconf_nextfile(const char *name)
+{
+	struct file *iter;
+	struct file *file = file_lookup(name);
+	struct buffer *buf = xmalloc(sizeof(*buf));
+	memset(buf, 0, sizeof(*buf));
+
+	current_buf->state = YY_CURRENT_BUFFER;
+	yyin = zconf_fopen(file->name);
+	if (!yyin) {
+		fprintf(stderr, "%s:%d: can't open file \"%s\"\n",
+			zconf_curname(), zconf_lineno(), file->name);
+		exit(1);
+	}
+	yy_switch_to_buffer(yy_create_buffer(yyin, YY_BUF_SIZE));
+	buf->parent = current_buf;
+	current_buf = buf;
+
+	current_file->lineno = yylineno;
+	file->parent = current_file;
+
+	for (iter = current_file; iter; iter = iter->parent) {
+		if (!strcmp(iter->name, file->name)) {
+			fprintf(stderr,
+				"Recursive inclusion detected.\n"
+				"Inclusion path:\n"
+				"  current file : %s\n", file->name);
+			iter = file;
+			do {
+				iter = iter->parent;
+				fprintf(stderr, "  included from: %s:%d\n",
+					iter->name, iter->lineno - 1);
+			} while (strcmp(iter->name, file->name));
+			exit(1);
+		}
+	}
+
+	yylineno = 1;
+	current_file = file;
+}
+
+static void zconf_endfile(void)
+{
+	struct buffer *parent;
+
+	current_file = current_file->parent;
+	if (current_file)
+		yylineno = current_file->lineno;
+
+	parent = current_buf->parent;
+	if (parent) {
+		fclose(yyin);
+		yy_delete_buffer(YY_CURRENT_BUFFER);
+		yy_switch_to_buffer(parent->state);
+	}
+	free(current_buf);
+	current_buf = parent;
+}
+
+int zconf_lineno(void)
+{
+	return current_pos.lineno;
+}
+
+const char *zconf_curname(void)
+{
+	return current_pos.file ? current_pos.file->name : "<none>";
+}
diff --git a/backport/kconf/list.h b/backport/kconf/list.h
new file mode 100644
index 000000000000..45cb237ab7ef
--- /dev/null
+++ b/backport/kconf/list.h
@@ -0,0 +1,132 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef LIST_H
+#define LIST_H
+
+/*
+ * Copied from include/linux/...
+ */
+
+#undef offsetof
+#define offsetof(TYPE, MEMBER) ((size_t) &((TYPE *)0)->MEMBER)
+
+/**
+ * container_of - cast a member of a structure out to the containing structure
+ * @ptr:        the pointer to the member.
+ * @type:       the type of the container struct this is embedded in.
+ * @member:     the name of the member within the struct.
+ *
+ */
+#define container_of(ptr, type, member) ({                      \
+	const typeof( ((type *)0)->member ) *__mptr = (ptr);    \
+	(type *)( (char *)__mptr - offsetof(type,member) );})
+
+
+struct list_head {
+	struct list_head *next, *prev;
+};
+
+
+#define LIST_HEAD_INIT(name) { &(name), &(name) }
+
+#define LIST_HEAD(name) \
+	struct list_head name = LIST_HEAD_INIT(name)
+
+/**
+ * list_entry - get the struct for this entry
+ * @ptr:	the &struct list_head pointer.
+ * @type:	the type of the struct this is embedded in.
+ * @member:	the name of the list_head within the struct.
+ */
+#define list_entry(ptr, type, member) \
+	container_of(ptr, type, member)
+
+/**
+ * list_for_each_entry	-	iterate over list of given type
+ * @pos:	the type * to use as a loop cursor.
+ * @head:	the head for your list.
+ * @member:	the name of the list_head within the struct.
+ */
+#define list_for_each_entry(pos, head, member)				\
+	for (pos = list_entry((head)->next, typeof(*pos), member);	\
+	     &pos->member != (head); 	\
+	     pos = list_entry(pos->member.next, typeof(*pos), member))
+
+/**
+ * list_for_each_entry_safe - iterate over list of given type safe against removal of list entry
+ * @pos:	the type * to use as a loop cursor.
+ * @n:		another type * to use as temporary storage
+ * @head:	the head for your list.
+ * @member:	the name of the list_head within the struct.
+ */
+#define list_for_each_entry_safe(pos, n, head, member)			\
+	for (pos = list_entry((head)->next, typeof(*pos), member),	\
+		n = list_entry(pos->member.next, typeof(*pos), member);	\
+	     &pos->member != (head);					\
+	     pos = n, n = list_entry(n->member.next, typeof(*n), member))
+
+/**
+ * list_empty - tests whether a list is empty
+ * @head: the list to test.
+ */
+static inline int list_empty(const struct list_head *head)
+{
+	return head->next == head;
+}
+
+/*
+ * Insert a new entry between two known consecutive entries.
+ *
+ * This is only for internal list manipulation where we know
+ * the prev/next entries already!
+ */
+static inline void __list_add(struct list_head *_new,
+			      struct list_head *prev,
+			      struct list_head *next)
+{
+	next->prev = _new;
+	_new->next = next;
+	_new->prev = prev;
+	prev->next = _new;
+}
+
+/**
+ * list_add_tail - add a new entry
+ * @new: new entry to be added
+ * @head: list head to add it before
+ *
+ * Insert a new entry before the specified head.
+ * This is useful for implementing queues.
+ */
+static inline void list_add_tail(struct list_head *_new, struct list_head *head)
+{
+	__list_add(_new, head->prev, head);
+}
+
+/*
+ * Delete a list entry by making the prev/next entries
+ * point to each other.
+ *
+ * This is only for internal list manipulation where we know
+ * the prev/next entries already!
+ */
+static inline void __list_del(struct list_head *prev, struct list_head *next)
+{
+	next->prev = prev;
+	prev->next = next;
+}
+
+#define LIST_POISON1  ((void *) 0x00100100)
+#define LIST_POISON2  ((void *) 0x00200200)
+/**
+ * list_del - deletes entry from list.
+ * @entry: the element to delete from the list.
+ * Note: list_empty() on entry does not return true after this, the entry is
+ * in an undefined state.
+ */
+static inline void list_del(struct list_head *entry)
+{
+	__list_del(entry->prev, entry->next);
+	entry->next = (struct list_head*)LIST_POISON1;
+	entry->prev = (struct list_head*)LIST_POISON2;
+}
+#endif
diff --git a/backport/kconf/lkc.h b/backport/kconf/lkc.h
new file mode 100644
index 000000000000..fa8c010aa683
--- /dev/null
+++ b/backport/kconf/lkc.h
@@ -0,0 +1,156 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (C) 2002 Roman Zippel <zippel@linux-m68k.org>
+ */
+
+#ifndef LKC_H
+#define LKC_H
+
+#include <assert.h>
+#include <stdio.h>
+#include <stdlib.h>
+
+#include "expr.h"
+
+#ifdef __cplusplus
+extern "C" {
+#endif
+
+#include "lkc_proto.h"
+
+#define SRCTREE "srctree"
+
+#ifndef CONFIG_
+#define CONFIG_ "CONFIG_"
+#endif
+static inline const char *CONFIG_prefix(void)
+{
+	return getenv( "CONFIG_" ) ?: CONFIG_;
+}
+#undef CONFIG_
+#define CONFIG_ CONFIG_prefix()
+
+extern int yylineno;
+void zconfdump(FILE *out);
+void zconf_starthelp(void);
+FILE *zconf_fopen(const char *name);
+void zconf_initscan(const char *name);
+void zconf_nextfile(const char *name);
+int zconf_lineno(void);
+const char *zconf_curname(void);
+
+/* confdata.c */
+const char *conf_get_configname(void);
+void set_all_choice_values(struct symbol *csym);
+
+/* confdata.c and expr.c */
+static inline void xfwrite(const void *str, size_t len, size_t count, FILE *out)
+{
+	assert(len != 0);
+
+	if (fwrite(str, len, count, out) != count)
+		fprintf(stderr, "Error in writing or end of file.\n");
+}
+
+/* util.c */
+struct file *file_lookup(const char *name);
+void *xmalloc(size_t size);
+void *xcalloc(size_t nmemb, size_t size);
+void *xrealloc(void *p, size_t size);
+char *xstrdup(const char *s);
+char *xstrndup(const char *s, size_t n);
+
+/* lexer.l */
+int yylex(void);
+
+struct gstr {
+	size_t len;
+	char  *s;
+	/*
+	* when max_width is not zero long lines in string s (if any) get
+	* wrapped not to exceed the max_width value
+	*/
+	int max_width;
+};
+struct gstr str_new(void);
+void str_free(struct gstr *gs);
+void str_append(struct gstr *gs, const char *s);
+void str_printf(struct gstr *gs, const char *fmt, ...);
+const char *str_get(struct gstr *gs);
+
+/* menu.c */
+void _menu_init(void);
+void menu_warn(struct menu *menu, const char *fmt, ...);
+struct menu *menu_add_menu(void);
+void menu_end_menu(void);
+void menu_add_entry(struct symbol *sym);
+void menu_add_dep(struct expr *dep);
+void menu_add_visibility(struct expr *dep);
+struct property *menu_add_prompt(enum prop_type type, char *prompt, struct expr *dep);
+void menu_add_expr(enum prop_type type, struct expr *expr, struct expr *dep);
+void menu_add_symbol(enum prop_type type, struct symbol *sym, struct expr *dep);
+void menu_finalize(struct menu *parent);
+void menu_set_type(int type);
+
+extern struct menu rootmenu;
+
+bool menu_is_empty(struct menu *menu);
+bool menu_is_visible(struct menu *menu);
+bool menu_has_prompt(struct menu *menu);
+const char *menu_get_prompt(struct menu *menu);
+struct menu *menu_get_root_menu(struct menu *menu);
+struct menu *menu_get_parent_menu(struct menu *menu);
+bool menu_has_help(struct menu *menu);
+const char *menu_get_help(struct menu *menu);
+struct gstr get_relations_str(struct symbol **sym_arr, struct list_head *head);
+void menu_get_ext_help(struct menu *menu, struct gstr *help);
+
+/* symbol.c */
+void sym_clear_all_valid(void);
+struct symbol *sym_choice_default(struct symbol *sym);
+struct property *sym_get_range_prop(struct symbol *sym);
+const char *sym_get_string_default(struct symbol *sym);
+struct symbol *sym_check_deps(struct symbol *sym);
+struct symbol *prop_get_symbol(struct property *prop);
+
+static inline tristate sym_get_tristate_value(struct symbol *sym)
+{
+	return sym->curr.tri;
+}
+
+
+static inline struct symbol *sym_get_choice_value(struct symbol *sym)
+{
+	return (struct symbol *)sym->curr.val;
+}
+
+static inline bool sym_set_choice_value(struct symbol *ch, struct symbol *chval)
+{
+	return sym_set_tristate_value(chval, yes);
+}
+
+static inline bool sym_is_choice(struct symbol *sym)
+{
+	return sym->flags & SYMBOL_CHOICE ? true : false;
+}
+
+static inline bool sym_is_choice_value(struct symbol *sym)
+{
+	return sym->flags & SYMBOL_CHOICEVAL ? true : false;
+}
+
+static inline bool sym_is_optional(struct symbol *sym)
+{
+	return sym->flags & SYMBOL_OPTIONAL ? true : false;
+}
+
+static inline bool sym_has_value(struct symbol *sym)
+{
+	return sym->flags & SYMBOL_DEF_USER ? true : false;
+}
+
+#ifdef __cplusplus
+}
+#endif
+
+#endif /* LKC_H */
diff --git a/backport/kconf/lkc_proto.h b/backport/kconf/lkc_proto.h
new file mode 100644
index 000000000000..edd1e617b25c
--- /dev/null
+++ b/backport/kconf/lkc_proto.h
@@ -0,0 +1,52 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#include <stdarg.h>
+
+/* confdata.c */
+void conf_parse(const char *name);
+int conf_read(const char *name);
+int conf_read_simple(const char *name, int);
+int conf_write_defconfig(const char *name);
+int conf_write(const char *name);
+int conf_write_autoconf(int overwrite);
+void conf_set_changed(bool val);
+bool conf_get_changed(void);
+void conf_set_changed_callback(void (*fn)(void));
+void conf_set_message_callback(void (*fn)(const char *s));
+
+/* symbol.c */
+extern struct symbol * symbol_hash[SYMBOL_HASHSIZE];
+
+struct symbol * sym_lookup(const char *name, int flags);
+struct symbol * sym_find(const char *name);
+void print_symbol_for_listconfig(struct symbol *sym);
+struct symbol ** sym_re_search(const char *pattern);
+const char * sym_type_name(enum symbol_type type);
+void sym_calc_value(struct symbol *sym);
+enum symbol_type sym_get_type(struct symbol *sym);
+bool sym_tristate_within_range(struct symbol *sym,tristate tri);
+bool sym_set_tristate_value(struct symbol *sym,tristate tri);
+tristate sym_toggle_tristate_value(struct symbol *sym);
+bool sym_string_valid(struct symbol *sym, const char *newval);
+bool sym_string_within_range(struct symbol *sym, const char *str);
+bool sym_set_string_value(struct symbol *sym, const char *newval);
+bool sym_is_changeable(struct symbol *sym);
+struct property * sym_get_choice_prop(struct symbol *sym);
+const char * sym_get_string_value(struct symbol *sym);
+
+const char * prop_get_type_name(enum prop_type type);
+
+/* preprocess.c */
+enum variable_flavor {
+	VAR_SIMPLE,
+	VAR_RECURSIVE,
+	VAR_APPEND,
+};
+void env_write_dep(FILE *f, const char *auto_conf_name);
+void variable_add(const char *name, const char *value,
+		  enum variable_flavor flavor);
+void variable_all_del(void);
+char *expand_dollar(const char **str);
+char *expand_one_token(const char **str);
+
+/* expr.c */
+void expr_print(struct expr *e, void (*fn)(void *, struct symbol *, const char *), void *data, int prevtoken);
diff --git a/backport/kconf/lxdialog/.gitignore b/backport/kconf/lxdialog/.gitignore
new file mode 100644
index 000000000000..90b08ff025a6
--- /dev/null
+++ b/backport/kconf/lxdialog/.gitignore
@@ -0,0 +1,4 @@
+#
+# Generated files
+#
+lxdialog
diff --git a/backport/kconf/lxdialog/BIG.FAT.WARNING b/backport/kconf/lxdialog/BIG.FAT.WARNING
new file mode 100644
index 000000000000..7cb5a7ec93d2
--- /dev/null
+++ b/backport/kconf/lxdialog/BIG.FAT.WARNING
@@ -0,0 +1,4 @@
+This is NOT the official version of dialog.  This version has been
+significantly modified from the original.  It is for use by the Linux
+kernel configuration script.  Please do not bother Savio Lam with
+questions about this program.
diff --git a/backport/kconf/lxdialog/checklist.c b/backport/kconf/lxdialog/checklist.c
new file mode 100644
index 000000000000..fd161cfff121
--- /dev/null
+++ b/backport/kconf/lxdialog/checklist.c
@@ -0,0 +1,319 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ *  checklist.c -- implements the checklist box
+ *
+ *  ORIGINAL AUTHOR: Savio Lam (lam836@cs.cuhk.hk)
+ *     Stuart Herbert - S.Herbert@sheffield.ac.uk: radiolist extension
+ *     Alessandro Rubini - rubini@ipvvis.unipv.it: merged the two
+ *  MODIFIED FOR LINUX KERNEL CONFIG BY: William Roadcap (roadcap@cfw.com)
+ */
+
+#include "dialog.h"
+
+static int list_width, check_x, item_x;
+
+/*
+ * Print list item
+ */
+static void print_item(WINDOW * win, int choice, int selected)
+{
+	int i;
+	char *list_item = malloc(list_width + 1);
+
+	strncpy(list_item, item_str(), list_width - item_x);
+	list_item[list_width - item_x] = '\0';
+
+	/* Clear 'residue' of last item */
+	wattrset(win, dlg.menubox.atr);
+	wmove(win, choice, 0);
+	for (i = 0; i < list_width; i++)
+		waddch(win, ' ');
+
+	wmove(win, choice, check_x);
+	wattrset(win, selected ? dlg.check_selected.atr
+		 : dlg.check.atr);
+	if (!item_is_tag(':'))
+		wprintw(win, "(%c)", item_is_tag('X') ? 'X' : ' ');
+
+	wattrset(win, selected ? dlg.tag_selected.atr : dlg.tag.atr);
+	mvwaddch(win, choice, item_x, list_item[0]);
+	wattrset(win, selected ? dlg.item_selected.atr : dlg.item.atr);
+	waddstr(win, list_item + 1);
+	if (selected) {
+		wmove(win, choice, check_x + 1);
+		wrefresh(win);
+	}
+	free(list_item);
+}
+
+/*
+ * Print the scroll indicators.
+ */
+static void print_arrows(WINDOW * win, int choice, int item_no, int scroll,
+	     int y, int x, int height)
+{
+	wmove(win, y, x);
+
+	if (scroll > 0) {
+		wattrset(win, dlg.uarrow.atr);
+		waddch(win, ACS_UARROW);
+		waddstr(win, "(-)");
+	} else {
+		wattrset(win, dlg.menubox.atr);
+		waddch(win, ACS_HLINE);
+		waddch(win, ACS_HLINE);
+		waddch(win, ACS_HLINE);
+		waddch(win, ACS_HLINE);
+	}
+
+	y = y + height + 1;
+	wmove(win, y, x);
+
+	if ((height < item_no) && (scroll + choice < item_no - 1)) {
+		wattrset(win, dlg.darrow.atr);
+		waddch(win, ACS_DARROW);
+		waddstr(win, "(+)");
+	} else {
+		wattrset(win, dlg.menubox_border.atr);
+		waddch(win, ACS_HLINE);
+		waddch(win, ACS_HLINE);
+		waddch(win, ACS_HLINE);
+		waddch(win, ACS_HLINE);
+	}
+}
+
+/*
+ *  Display the termination buttons
+ */
+static void print_buttons(WINDOW * dialog, int height, int width, int selected)
+{
+	int x = width / 2 - 11;
+	int y = height - 2;
+
+	print_button(dialog, "Select", y, x, selected == 0);
+	print_button(dialog, " Help ", y, x + 14, selected == 1);
+
+	wmove(dialog, y, x + 1 + 14 * selected);
+	wrefresh(dialog);
+}
+
+/*
+ * Display a dialog box with a list of options that can be turned on or off
+ * in the style of radiolist (only one option turned on at a time).
+ */
+int dialog_checklist(const char *title, const char *prompt, int height,
+		     int width, int list_height)
+{
+	int i, x, y, box_x, box_y;
+	int key = 0, button = 0, choice = 0, scroll = 0, max_choice;
+	WINDOW *dialog, *list;
+
+	/* which item to highlight */
+	item_foreach() {
+		if (item_is_tag('X'))
+			choice = item_n();
+		if (item_is_selected()) {
+			choice = item_n();
+			break;
+		}
+	}
+
+do_resize:
+	if (getmaxy(stdscr) < (height + CHECKLIST_HEIGTH_MIN))
+		return -ERRDISPLAYTOOSMALL;
+	if (getmaxx(stdscr) < (width + CHECKLIST_WIDTH_MIN))
+		return -ERRDISPLAYTOOSMALL;
+
+	max_choice = MIN(list_height, item_count());
+
+	/* center dialog box on screen */
+	x = (getmaxx(stdscr) - width) / 2;
+	y = (getmaxy(stdscr) - height) / 2;
+
+	draw_shadow(stdscr, y, x, height, width);
+
+	dialog = newwin(height, width, y, x);
+	keypad(dialog, TRUE);
+
+	draw_box(dialog, 0, 0, height, width,
+		 dlg.dialog.atr, dlg.border.atr);
+	wattrset(dialog, dlg.border.atr);
+	mvwaddch(dialog, height - 3, 0, ACS_LTEE);
+	for (i = 0; i < width - 2; i++)
+		waddch(dialog, ACS_HLINE);
+	wattrset(dialog, dlg.dialog.atr);
+	waddch(dialog, ACS_RTEE);
+
+	print_title(dialog, title, width);
+
+	wattrset(dialog, dlg.dialog.atr);
+	print_autowrap(dialog, prompt, width - 2, 1, 3);
+
+	list_width = width - 6;
+	box_y = height - list_height - 5;
+	box_x = (width - list_width) / 2 - 1;
+
+	/* create new window for the list */
+	list = subwin(dialog, list_height, list_width, y + box_y + 1,
+		      x + box_x + 1);
+
+	keypad(list, TRUE);
+
+	/* draw a box around the list items */
+	draw_box(dialog, box_y, box_x, list_height + 2, list_width + 2,
+		 dlg.menubox_border.atr, dlg.menubox.atr);
+
+	/* Find length of longest item in order to center checklist */
+	check_x = 0;
+	item_foreach()
+		check_x = MAX(check_x, strlen(item_str()) + 4);
+	check_x = MIN(check_x, list_width);
+
+	check_x = (list_width - check_x) / 2;
+	item_x = check_x + 4;
+
+	if (choice >= list_height) {
+		scroll = choice - list_height + 1;
+		choice -= scroll;
+	}
+
+	/* Print the list */
+	for (i = 0; i < max_choice; i++) {
+		item_set(scroll + i);
+		print_item(list, i, i == choice);
+	}
+
+	print_arrows(dialog, choice, item_count(), scroll,
+		     box_y, box_x + check_x + 5, list_height);
+
+	print_buttons(dialog, height, width, 0);
+
+	wnoutrefresh(dialog);
+	wnoutrefresh(list);
+	doupdate();
+
+	while (key != KEY_ESC) {
+		key = wgetch(dialog);
+
+		for (i = 0; i < max_choice; i++) {
+			item_set(i + scroll);
+			if (toupper(key) == toupper(item_str()[0]))
+				break;
+		}
+
+		if (i < max_choice || key == KEY_UP || key == KEY_DOWN ||
+		    key == '+' || key == '-') {
+			if (key == KEY_UP || key == '-') {
+				if (!choice) {
+					if (!scroll)
+						continue;
+					/* Scroll list down */
+					if (list_height > 1) {
+						/* De-highlight current first item */
+						item_set(scroll);
+						print_item(list, 0, FALSE);
+						scrollok(list, TRUE);
+						wscrl(list, -1);
+						scrollok(list, FALSE);
+					}
+					scroll--;
+					item_set(scroll);
+					print_item(list, 0, TRUE);
+					print_arrows(dialog, choice, item_count(),
+						     scroll, box_y, box_x + check_x + 5, list_height);
+
+					wnoutrefresh(dialog);
+					wrefresh(list);
+
+					continue;	/* wait for another key press */
+				} else
+					i = choice - 1;
+			} else if (key == KEY_DOWN || key == '+') {
+				if (choice == max_choice - 1) {
+					if (scroll + choice >= item_count() - 1)
+						continue;
+					/* Scroll list up */
+					if (list_height > 1) {
+						/* De-highlight current last item before scrolling up */
+						item_set(scroll + max_choice - 1);
+						print_item(list,
+							    max_choice - 1,
+							    FALSE);
+						scrollok(list, TRUE);
+						wscrl(list, 1);
+						scrollok(list, FALSE);
+					}
+					scroll++;
+					item_set(scroll + max_choice - 1);
+					print_item(list, max_choice - 1, TRUE);
+
+					print_arrows(dialog, choice, item_count(),
+						     scroll, box_y, box_x + check_x + 5, list_height);
+
+					wnoutrefresh(dialog);
+					wrefresh(list);
+
+					continue;	/* wait for another key press */
+				} else
+					i = choice + 1;
+			}
+			if (i != choice) {
+				/* De-highlight current item */
+				item_set(scroll + choice);
+				print_item(list, choice, FALSE);
+				/* Highlight new item */
+				choice = i;
+				item_set(scroll + choice);
+				print_item(list, choice, TRUE);
+				wnoutrefresh(dialog);
+				wrefresh(list);
+			}
+			continue;	/* wait for another key press */
+		}
+		switch (key) {
+		case 'H':
+		case 'h':
+		case '?':
+			button = 1;
+			/* fall-through */
+		case 'S':
+		case 's':
+		case ' ':
+		case '\n':
+			item_foreach()
+				item_set_selected(0);
+			item_set(scroll + choice);
+			item_set_selected(1);
+			delwin(list);
+			delwin(dialog);
+			return button;
+		case TAB:
+		case KEY_LEFT:
+		case KEY_RIGHT:
+			button = ((key == KEY_LEFT ? --button : ++button) < 0)
+			    ? 1 : (button > 1 ? 0 : button);
+
+			print_buttons(dialog, height, width, button);
+			wrefresh(dialog);
+			break;
+		case 'X':
+		case 'x':
+			key = KEY_ESC;
+			break;
+		case KEY_ESC:
+			key = on_key_esc(dialog);
+			break;
+		case KEY_RESIZE:
+			delwin(list);
+			delwin(dialog);
+			on_key_resize();
+			goto do_resize;
+		}
+
+		/* Now, update everything... */
+		doupdate();
+	}
+	delwin(list);
+	delwin(dialog);
+	return key;		/* ESC pressed */
+}
diff --git a/backport/kconf/lxdialog/dialog.h b/backport/kconf/lxdialog/dialog.h
new file mode 100644
index 000000000000..68b565e3c495
--- /dev/null
+++ b/backport/kconf/lxdialog/dialog.h
@@ -0,0 +1,238 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+/*
+ *  dialog.h -- common declarations for all dialog modules
+ *
+ *  AUTHOR: Savio Lam (lam836@cs.cuhk.hk)
+ */
+
+#include <sys/types.h>
+#include <fcntl.h>
+#include <unistd.h>
+#include <ctype.h>
+#include <stdlib.h>
+#include <string.h>
+#include <stdbool.h>
+
+#ifdef __sun__
+#define CURS_MACROS
+#endif
+#include <ncurses.h>
+
+/*
+ * Colors in ncurses 1.9.9e do not work properly since foreground and
+ * background colors are OR'd rather than separately masked.  This version
+ * of dialog was hacked to work with ncurses 1.9.9e, making it incompatible
+ * with standard curses.  The simplest fix (to make this work with standard
+ * curses) uses the wbkgdset() function, not used in the original hack.
+ * Turn it off if we're building with 1.9.9e, since it just confuses things.
+ */
+#if defined(NCURSES_VERSION) && defined(_NEED_WRAP) && !defined(GCC_PRINTFLIKE)
+#define OLD_NCURSES 1
+#undef  wbkgdset
+#define wbkgdset(w,p)		/*nothing */
+#else
+#define OLD_NCURSES 0
+#endif
+
+#define TR(params) _tracef params
+
+#define KEY_ESC 27
+#define TAB 9
+#define MAX_LEN 2048
+#define BUF_SIZE (10*1024)
+#define MIN(x,y) (x < y ? x : y)
+#define MAX(x,y) (x > y ? x : y)
+
+#ifndef ACS_ULCORNER
+#define ACS_ULCORNER '+'
+#endif
+#ifndef ACS_LLCORNER
+#define ACS_LLCORNER '+'
+#endif
+#ifndef ACS_URCORNER
+#define ACS_URCORNER '+'
+#endif
+#ifndef ACS_LRCORNER
+#define ACS_LRCORNER '+'
+#endif
+#ifndef ACS_HLINE
+#define ACS_HLINE '-'
+#endif
+#ifndef ACS_VLINE
+#define ACS_VLINE '|'
+#endif
+#ifndef ACS_LTEE
+#define ACS_LTEE '+'
+#endif
+#ifndef ACS_RTEE
+#define ACS_RTEE '+'
+#endif
+#ifndef ACS_UARROW
+#define ACS_UARROW '^'
+#endif
+#ifndef ACS_DARROW
+#define ACS_DARROW 'v'
+#endif
+
+/* error return codes */
+#define ERRDISPLAYTOOSMALL (KEY_MAX + 1)
+
+/*
+ *   Color definitions
+ */
+struct dialog_color {
+	chtype atr;	/* Color attribute */
+	int fg;		/* foreground */
+	int bg;		/* background */
+	int hl;		/* highlight this item */
+};
+
+struct subtitle_list {
+	struct subtitle_list *next;
+	const char *text;
+};
+
+struct dialog_info {
+	const char *backtitle;
+	struct subtitle_list *subtitles;
+	struct dialog_color screen;
+	struct dialog_color shadow;
+	struct dialog_color dialog;
+	struct dialog_color title;
+	struct dialog_color border;
+	struct dialog_color button_active;
+	struct dialog_color button_inactive;
+	struct dialog_color button_key_active;
+	struct dialog_color button_key_inactive;
+	struct dialog_color button_label_active;
+	struct dialog_color button_label_inactive;
+	struct dialog_color inputbox;
+	struct dialog_color inputbox_border;
+	struct dialog_color searchbox;
+	struct dialog_color searchbox_title;
+	struct dialog_color searchbox_border;
+	struct dialog_color position_indicator;
+	struct dialog_color menubox;
+	struct dialog_color menubox_border;
+	struct dialog_color item;
+	struct dialog_color item_selected;
+	struct dialog_color tag;
+	struct dialog_color tag_selected;
+	struct dialog_color tag_key;
+	struct dialog_color tag_key_selected;
+	struct dialog_color check;
+	struct dialog_color check_selected;
+	struct dialog_color uarrow;
+	struct dialog_color darrow;
+};
+
+/*
+ * Global variables
+ */
+extern struct dialog_info dlg;
+extern char dialog_input_result[];
+extern int saved_x, saved_y;		/* Needed in signal handler in mconf.c */
+
+/*
+ * Function prototypes
+ */
+
+/* item list as used by checklist and menubox */
+void item_reset(void);
+void item_make(const char *fmt, ...);
+void item_add_str(const char *fmt, ...);
+void item_set_tag(char tag);
+void item_set_data(void *p);
+void item_set_selected(int val);
+int item_activate_selected(void);
+void *item_data(void);
+char item_tag(void);
+
+/* item list manipulation for lxdialog use */
+#define MAXITEMSTR 200
+struct dialog_item {
+	char str[MAXITEMSTR];	/* prompt displayed */
+	char tag;
+	void *data;	/* pointer to menu item - used by menubox+checklist */
+	int selected;	/* Set to 1 by dialog_*() function if selected. */
+};
+
+/* list of lialog_items */
+struct dialog_list {
+	struct dialog_item node;
+	struct dialog_list *next;
+};
+
+extern struct dialog_list *item_cur;
+extern struct dialog_list item_nil;
+extern struct dialog_list *item_head;
+
+int item_count(void);
+void item_set(int n);
+int item_n(void);
+const char *item_str(void);
+int item_is_selected(void);
+int item_is_tag(char tag);
+#define item_foreach() \
+	for (item_cur = item_head ? item_head: item_cur; \
+	     item_cur && (item_cur != &item_nil); item_cur = item_cur->next)
+
+/* generic key handlers */
+int on_key_esc(WINDOW *win);
+int on_key_resize(void);
+
+/* minimum (re)size values */
+#define CHECKLIST_HEIGTH_MIN 6	/* For dialog_checklist() */
+#define CHECKLIST_WIDTH_MIN 6
+#define INPUTBOX_HEIGTH_MIN 2	/* For dialog_inputbox() */
+#define INPUTBOX_WIDTH_MIN 2
+#define MENUBOX_HEIGTH_MIN 15	/* For dialog_menu() */
+#define MENUBOX_WIDTH_MIN 65
+#define TEXTBOX_HEIGTH_MIN 8	/* For dialog_textbox() */
+#define TEXTBOX_WIDTH_MIN 8
+#define YESNO_HEIGTH_MIN 4	/* For dialog_yesno() */
+#define YESNO_WIDTH_MIN 4
+#define WINDOW_HEIGTH_MIN 19	/* For init_dialog() */
+#define WINDOW_WIDTH_MIN 80
+
+int init_dialog(const char *backtitle);
+void set_dialog_backtitle(const char *backtitle);
+void set_dialog_subtitles(struct subtitle_list *subtitles);
+void end_dialog(int x, int y);
+void attr_clear(WINDOW * win, int height, int width, chtype attr);
+void dialog_clear(void);
+void print_autowrap(WINDOW * win, const char *prompt, int width, int y, int x);
+void print_button(WINDOW * win, const char *label, int y, int x, int selected);
+void print_title(WINDOW *dialog, const char *title, int width);
+void draw_box(WINDOW * win, int y, int x, int height, int width, chtype box,
+	      chtype border);
+void draw_shadow(WINDOW * win, int y, int x, int height, int width);
+
+int first_alpha(const char *string, const char *exempt);
+int dialog_yesno(const char *title, const char *prompt, int height, int width);
+int dialog_msgbox(const char *title, const char *prompt, int height,
+		  int width, int pause);
+
+
+typedef void (*update_text_fn)(char *buf, size_t start, size_t end, void
+			       *_data);
+int dialog_textbox(const char *title, char *tbuf, int initial_height,
+		   int initial_width, int *keys, int *_vscroll, int *_hscroll,
+		   update_text_fn update_text, void *data);
+int dialog_menu(const char *title, const char *prompt,
+		const void *selected, int *s_scroll);
+int dialog_checklist(const char *title, const char *prompt, int height,
+		     int width, int list_height);
+int dialog_inputbox(const char *title, const char *prompt, int height,
+		    int width, const char *init);
+
+/*
+ * This is the base for fictitious keys, which activate
+ * the buttons.
+ *
+ * Mouse-generated keys are the following:
+ *   -- the first 32 are used as numbers, in addition to '0'-'9'
+ *   -- the lowercase are used to signal mouse-enter events (M_EVENT + 'o')
+ *   -- uppercase chars are used to invoke the button (M_EVENT + 'O')
+ */
+#define M_EVENT (KEY_MAX+1)
diff --git a/backport/kconf/lxdialog/inputbox.c b/backport/kconf/lxdialog/inputbox.c
new file mode 100644
index 000000000000..1dcfb288ee63
--- /dev/null
+++ b/backport/kconf/lxdialog/inputbox.c
@@ -0,0 +1,289 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ *  inputbox.c -- implements the input box
+ *
+ *  ORIGINAL AUTHOR: Savio Lam (lam836@cs.cuhk.hk)
+ *  MODIFIED FOR LINUX KERNEL CONFIG BY: William Roadcap (roadcap@cfw.com)
+ */
+
+#include "dialog.h"
+
+char dialog_input_result[MAX_LEN + 1];
+
+/*
+ *  Print the termination buttons
+ */
+static void print_buttons(WINDOW * dialog, int height, int width, int selected)
+{
+	int x = width / 2 - 11;
+	int y = height - 2;
+
+	print_button(dialog, "  Ok  ", y, x, selected == 0);
+	print_button(dialog, " Help ", y, x + 14, selected == 1);
+
+	wmove(dialog, y, x + 1 + 14 * selected);
+	wrefresh(dialog);
+}
+
+/*
+ * Display a dialog box for inputing a string
+ */
+int dialog_inputbox(const char *title, const char *prompt, int height, int width,
+		    const char *init)
+{
+	int i, x, y, box_y, box_x, box_width;
+	int input_x = 0, key = 0, button = -1;
+	int show_x, len, pos;
+	char *instr = dialog_input_result;
+	WINDOW *dialog;
+
+	if (!init)
+		instr[0] = '\0';
+	else
+		strcpy(instr, init);
+
+do_resize:
+	if (getmaxy(stdscr) <= (height - INPUTBOX_HEIGTH_MIN))
+		return -ERRDISPLAYTOOSMALL;
+	if (getmaxx(stdscr) <= (width - INPUTBOX_WIDTH_MIN))
+		return -ERRDISPLAYTOOSMALL;
+
+	/* center dialog box on screen */
+	x = (getmaxx(stdscr) - width) / 2;
+	y = (getmaxy(stdscr) - height) / 2;
+
+	draw_shadow(stdscr, y, x, height, width);
+
+	dialog = newwin(height, width, y, x);
+	keypad(dialog, TRUE);
+
+	draw_box(dialog, 0, 0, height, width,
+		 dlg.dialog.atr, dlg.border.atr);
+	wattrset(dialog, dlg.border.atr);
+	mvwaddch(dialog, height - 3, 0, ACS_LTEE);
+	for (i = 0; i < width - 2; i++)
+		waddch(dialog, ACS_HLINE);
+	wattrset(dialog, dlg.dialog.atr);
+	waddch(dialog, ACS_RTEE);
+
+	print_title(dialog, title, width);
+
+	wattrset(dialog, dlg.dialog.atr);
+	print_autowrap(dialog, prompt, width - 2, 1, 3);
+
+	/* Draw the input field box */
+	box_width = width - 6;
+	getyx(dialog, y, x);
+	box_y = y + 2;
+	box_x = (width - box_width) / 2;
+	draw_box(dialog, y + 1, box_x - 1, 3, box_width + 2,
+		 dlg.dialog.atr, dlg.border.atr);
+
+	print_buttons(dialog, height, width, 0);
+
+	/* Set up the initial value */
+	wmove(dialog, box_y, box_x);
+	wattrset(dialog, dlg.inputbox.atr);
+
+	len = strlen(instr);
+	pos = len;
+
+	if (len >= box_width) {
+		show_x = len - box_width + 1;
+		input_x = box_width - 1;
+		for (i = 0; i < box_width - 1; i++)
+			waddch(dialog, instr[show_x + i]);
+	} else {
+		show_x = 0;
+		input_x = len;
+		waddstr(dialog, instr);
+	}
+
+	wmove(dialog, box_y, box_x + input_x);
+
+	wrefresh(dialog);
+
+	while (key != KEY_ESC) {
+		key = wgetch(dialog);
+
+		if (button == -1) {	/* Input box selected */
+			switch (key) {
+			case TAB:
+			case KEY_UP:
+			case KEY_DOWN:
+				break;
+			case KEY_BACKSPACE:
+			case 8:   /* ^H */
+			case 127: /* ^? */
+				if (pos) {
+					wattrset(dialog, dlg.inputbox.atr);
+					if (input_x == 0) {
+						show_x--;
+					} else
+						input_x--;
+
+					if (pos < len) {
+						for (i = pos - 1; i < len; i++) {
+							instr[i] = instr[i+1];
+						}
+					}
+
+					pos--;
+					len--;
+					instr[len] = '\0';
+					wmove(dialog, box_y, box_x);
+					for (i = 0; i < box_width; i++) {
+						if (!instr[show_x + i]) {
+							waddch(dialog, ' ');
+							break;
+						}
+						waddch(dialog, instr[show_x + i]);
+					}
+					wmove(dialog, box_y, input_x + box_x);
+					wrefresh(dialog);
+				}
+				continue;
+			case KEY_LEFT:
+				if (pos > 0) {
+					if (input_x > 0) {
+						wmove(dialog, box_y, --input_x + box_x);
+					} else if (input_x == 0) {
+						show_x--;
+						wmove(dialog, box_y, box_x);
+						for (i = 0; i < box_width; i++) {
+							if (!instr[show_x + i]) {
+								waddch(dialog, ' ');
+								break;
+							}
+							waddch(dialog, instr[show_x + i]);
+						}
+						wmove(dialog, box_y, box_x);
+					}
+					pos--;
+				}
+				continue;
+			case KEY_RIGHT:
+				if (pos < len) {
+					if (input_x < box_width - 1) {
+						wmove(dialog, box_y, ++input_x + box_x);
+					} else if (input_x == box_width - 1) {
+						show_x++;
+						wmove(dialog, box_y, box_x);
+						for (i = 0; i < box_width; i++) {
+							if (!instr[show_x + i]) {
+								waddch(dialog, ' ');
+								break;
+							}
+							waddch(dialog, instr[show_x + i]);
+						}
+						wmove(dialog, box_y, input_x + box_x);
+					}
+					pos++;
+				}
+				continue;
+			default:
+				if (key < 0x100 && isprint(key)) {
+					if (len < MAX_LEN) {
+						wattrset(dialog, dlg.inputbox.atr);
+						if (pos < len) {
+							for (i = len; i > pos; i--)
+								instr[i] = instr[i-1];
+							instr[pos] = key;
+						} else {
+							instr[len] = key;
+						}
+						pos++;
+						len++;
+						instr[len] = '\0';
+
+						if (input_x == box_width - 1) {
+							show_x++;
+						} else {
+							input_x++;
+						}
+
+						wmove(dialog, box_y, box_x);
+						for (i = 0; i < box_width; i++) {
+							if (!instr[show_x + i]) {
+								waddch(dialog, ' ');
+								break;
+							}
+							waddch(dialog, instr[show_x + i]);
+						}
+						wmove(dialog, box_y, input_x + box_x);
+						wrefresh(dialog);
+					} else
+						flash();	/* Alarm user about overflow */
+					continue;
+				}
+			}
+		}
+		switch (key) {
+		case 'O':
+		case 'o':
+			delwin(dialog);
+			return 0;
+		case 'H':
+		case 'h':
+			delwin(dialog);
+			return 1;
+		case KEY_UP:
+		case KEY_LEFT:
+			switch (button) {
+			case -1:
+				button = 1;	/* Indicates "Help" button is selected */
+				print_buttons(dialog, height, width, 1);
+				break;
+			case 0:
+				button = -1;	/* Indicates input box is selected */
+				print_buttons(dialog, height, width, 0);
+				wmove(dialog, box_y, box_x + input_x);
+				wrefresh(dialog);
+				break;
+			case 1:
+				button = 0;	/* Indicates "OK" button is selected */
+				print_buttons(dialog, height, width, 0);
+				break;
+			}
+			break;
+		case TAB:
+		case KEY_DOWN:
+		case KEY_RIGHT:
+			switch (button) {
+			case -1:
+				button = 0;	/* Indicates "OK" button is selected */
+				print_buttons(dialog, height, width, 0);
+				break;
+			case 0:
+				button = 1;	/* Indicates "Help" button is selected */
+				print_buttons(dialog, height, width, 1);
+				break;
+			case 1:
+				button = -1;	/* Indicates input box is selected */
+				print_buttons(dialog, height, width, 0);
+				wmove(dialog, box_y, box_x + input_x);
+				wrefresh(dialog);
+				break;
+			}
+			break;
+		case ' ':
+		case '\n':
+			delwin(dialog);
+			return (button == -1 ? 0 : button);
+		case 'X':
+		case 'x':
+			key = KEY_ESC;
+			break;
+		case KEY_ESC:
+			key = on_key_esc(dialog);
+			break;
+		case KEY_RESIZE:
+			delwin(dialog);
+			on_key_resize();
+			goto do_resize;
+		}
+	}
+
+	delwin(dialog);
+	return KEY_ESC;		/* ESC pressed */
+}
diff --git a/backport/kconf/lxdialog/menubox.c b/backport/kconf/lxdialog/menubox.c
new file mode 100644
index 000000000000..58c2f8afe59b
--- /dev/null
+++ b/backport/kconf/lxdialog/menubox.c
@@ -0,0 +1,424 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ *  menubox.c -- implements the menu box
+ *
+ *  ORIGINAL AUTHOR: Savio Lam (lam836@cs.cuhk.hk)
+ *  MODIFIED FOR LINUX KERNEL CONFIG BY: William Roadcap (roadcapw@cfw.com)
+ */
+
+/*
+ *  Changes by Clifford Wolf (god@clifford.at)
+ *
+ *  [ 1998-06-13 ]
+ *
+ *    *)  A bugfix for the Page-Down problem
+ *
+ *    *)  Formerly when I used Page Down and Page Up, the cursor would be set
+ *        to the first position in the menu box.  Now lxdialog is a bit
+ *        smarter and works more like other menu systems (just have a look at
+ *        it).
+ *
+ *    *)  Formerly if I selected something my scrolling would be broken because
+ *        lxdialog is re-invoked by the Menuconfig shell script, can't
+ *        remember the last scrolling position, and just sets it so that the
+ *        cursor is at the bottom of the box.  Now it writes the temporary file
+ *        lxdialog.scrltmp which contains this information. The file is
+ *        deleted by lxdialog if the user leaves a submenu or enters a new
+ *        one, but it would be nice if Menuconfig could make another "rm -f"
+ *        just to be sure.  Just try it out - you will recognise a difference!
+ *
+ *  [ 1998-06-14 ]
+ *
+ *    *)  Now lxdialog is crash-safe against broken "lxdialog.scrltmp" files
+ *        and menus change their size on the fly.
+ *
+ *    *)  If for some reason the last scrolling position is not saved by
+ *        lxdialog, it sets the scrolling so that the selected item is in the
+ *        middle of the menu box, not at the bottom.
+ *
+ * 02 January 1999, Michael Elizabeth Chastain (mec@shout.net)
+ * Reset 'scroll' to 0 if the value from lxdialog.scrltmp is bogus.
+ * This fixes a bug in Menuconfig where using ' ' to descend into menus
+ * would leave mis-synchronized lxdialog.scrltmp files lying around,
+ * fscanf would read in 'scroll', and eventually that value would get used.
+ */
+
+#include "dialog.h"
+
+static int menu_width, item_x;
+
+/*
+ * Print menu item
+ */
+static void do_print_item(WINDOW * win, const char *item, int line_y,
+			  int selected, int hotkey)
+{
+	int j;
+	char *menu_item = malloc(menu_width + 1);
+
+	strncpy(menu_item, item, menu_width - item_x);
+	menu_item[menu_width - item_x] = '\0';
+	j = first_alpha(menu_item, "YyNnMmHh");
+
+	/* Clear 'residue' of last item */
+	wattrset(win, dlg.menubox.atr);
+	wmove(win, line_y, 0);
+#if OLD_NCURSES
+	{
+		int i;
+		for (i = 0; i < menu_width; i++)
+			waddch(win, ' ');
+	}
+#else
+	wclrtoeol(win);
+#endif
+	wattrset(win, selected ? dlg.item_selected.atr : dlg.item.atr);
+	mvwaddstr(win, line_y, item_x, menu_item);
+	if (hotkey) {
+		wattrset(win, selected ? dlg.tag_key_selected.atr
+			 : dlg.tag_key.atr);
+		mvwaddch(win, line_y, item_x + j, menu_item[j]);
+	}
+	if (selected) {
+		wmove(win, line_y, item_x + 1);
+	}
+	free(menu_item);
+	wrefresh(win);
+}
+
+#define print_item(index, choice, selected)				\
+do {									\
+	item_set(index);						\
+	do_print_item(menu, item_str(), choice, selected, !item_is_tag(':')); \
+} while (0)
+
+/*
+ * Print the scroll indicators.
+ */
+static void print_arrows(WINDOW * win, int item_no, int scroll, int y, int x,
+			 int height)
+{
+	int cur_y, cur_x;
+
+	getyx(win, cur_y, cur_x);
+
+	wmove(win, y, x);
+
+	if (scroll > 0) {
+		wattrset(win, dlg.uarrow.atr);
+		waddch(win, ACS_UARROW);
+		waddstr(win, "(-)");
+	} else {
+		wattrset(win, dlg.menubox.atr);
+		waddch(win, ACS_HLINE);
+		waddch(win, ACS_HLINE);
+		waddch(win, ACS_HLINE);
+		waddch(win, ACS_HLINE);
+	}
+
+	y = y + height + 1;
+	wmove(win, y, x);
+	wrefresh(win);
+
+	if ((height < item_no) && (scroll + height < item_no)) {
+		wattrset(win, dlg.darrow.atr);
+		waddch(win, ACS_DARROW);
+		waddstr(win, "(+)");
+	} else {
+		wattrset(win, dlg.menubox_border.atr);
+		waddch(win, ACS_HLINE);
+		waddch(win, ACS_HLINE);
+		waddch(win, ACS_HLINE);
+		waddch(win, ACS_HLINE);
+	}
+
+	wmove(win, cur_y, cur_x);
+	wrefresh(win);
+}
+
+/*
+ * Display the termination buttons.
+ */
+static void print_buttons(WINDOW * win, int height, int width, int selected)
+{
+	int x = width / 2 - 28;
+	int y = height - 2;
+
+	print_button(win, "Select", y, x, selected == 0);
+	print_button(win, " Exit ", y, x + 12, selected == 1);
+	print_button(win, " Help ", y, x + 24, selected == 2);
+	print_button(win, " Save ", y, x + 36, selected == 3);
+	print_button(win, " Load ", y, x + 48, selected == 4);
+
+	wmove(win, y, x + 1 + 12 * selected);
+	wrefresh(win);
+}
+
+/* scroll up n lines (n may be negative) */
+static void do_scroll(WINDOW *win, int *scroll, int n)
+{
+	/* Scroll menu up */
+	scrollok(win, TRUE);
+	wscrl(win, n);
+	scrollok(win, FALSE);
+	*scroll = *scroll + n;
+	wrefresh(win);
+}
+
+/*
+ * Display a menu for choosing among a number of options
+ */
+int dialog_menu(const char *title, const char *prompt,
+		const void *selected, int *s_scroll)
+{
+	int i, j, x, y, box_x, box_y;
+	int height, width, menu_height;
+	int key = 0, button = 0, scroll = 0, choice = 0;
+	int first_item =  0, max_choice;
+	WINDOW *dialog, *menu;
+
+do_resize:
+	height = getmaxy(stdscr);
+	width = getmaxx(stdscr);
+	if (height < MENUBOX_HEIGTH_MIN || width < MENUBOX_WIDTH_MIN)
+		return -ERRDISPLAYTOOSMALL;
+
+	height -= 4;
+	width  -= 5;
+	menu_height = height - 10;
+
+	max_choice = MIN(menu_height, item_count());
+
+	/* center dialog box on screen */
+	x = (getmaxx(stdscr) - width) / 2;
+	y = (getmaxy(stdscr) - height) / 2;
+
+	draw_shadow(stdscr, y, x, height, width);
+
+	dialog = newwin(height, width, y, x);
+	keypad(dialog, TRUE);
+
+	draw_box(dialog, 0, 0, height, width,
+		 dlg.dialog.atr, dlg.border.atr);
+	wattrset(dialog, dlg.border.atr);
+	mvwaddch(dialog, height - 3, 0, ACS_LTEE);
+	for (i = 0; i < width - 2; i++)
+		waddch(dialog, ACS_HLINE);
+	wattrset(dialog, dlg.dialog.atr);
+	wbkgdset(dialog, dlg.dialog.atr & A_COLOR);
+	waddch(dialog, ACS_RTEE);
+
+	print_title(dialog, title, width);
+
+	wattrset(dialog, dlg.dialog.atr);
+	print_autowrap(dialog, prompt, width - 2, 1, 3);
+
+	menu_width = width - 6;
+	box_y = height - menu_height - 5;
+	box_x = (width - menu_width) / 2 - 1;
+
+	/* create new window for the menu */
+	menu = subwin(dialog, menu_height, menu_width,
+		      y + box_y + 1, x + box_x + 1);
+	keypad(menu, TRUE);
+
+	/* draw a box around the menu items */
+	draw_box(dialog, box_y, box_x, menu_height + 2, menu_width + 2,
+		 dlg.menubox_border.atr, dlg.menubox.atr);
+
+	if (menu_width >= 80)
+		item_x = (menu_width - 70) / 2;
+	else
+		item_x = 4;
+
+	/* Set choice to default item */
+	item_foreach()
+		if (selected && (selected == item_data()))
+			choice = item_n();
+	/* get the saved scroll info */
+	scroll = *s_scroll;
+	if ((scroll <= choice) && (scroll + max_choice > choice) &&
+	   (scroll >= 0) && (scroll + max_choice <= item_count())) {
+		first_item = scroll;
+		choice = choice - scroll;
+	} else {
+		scroll = 0;
+	}
+	if ((choice >= max_choice)) {
+		if (choice >= item_count() - max_choice / 2)
+			scroll = first_item = item_count() - max_choice;
+		else
+			scroll = first_item = choice - max_choice / 2;
+		choice = choice - scroll;
+	}
+
+	/* Print the menu */
+	for (i = 0; i < max_choice; i++) {
+		print_item(first_item + i, i, i == choice);
+	}
+
+	wnoutrefresh(menu);
+
+	print_arrows(dialog, item_count(), scroll,
+		     box_y, box_x + item_x + 1, menu_height);
+
+	print_buttons(dialog, height, width, 0);
+	wmove(menu, choice, item_x + 1);
+	wrefresh(menu);
+
+	while (key != KEY_ESC) {
+		key = wgetch(menu);
+
+		if (key < 256 && isalpha(key))
+			key = tolower(key);
+
+		if (strchr("ynmh", key))
+			i = max_choice;
+		else {
+			for (i = choice + 1; i < max_choice; i++) {
+				item_set(scroll + i);
+				j = first_alpha(item_str(), "YyNnMmHh");
+				if (key == tolower(item_str()[j]))
+					break;
+			}
+			if (i == max_choice)
+				for (i = 0; i < max_choice; i++) {
+					item_set(scroll + i);
+					j = first_alpha(item_str(), "YyNnMmHh");
+					if (key == tolower(item_str()[j]))
+						break;
+				}
+		}
+
+		if (item_count() != 0 &&
+		    (i < max_choice ||
+		     key == KEY_UP || key == KEY_DOWN ||
+		     key == '-' || key == '+' ||
+		     key == KEY_PPAGE || key == KEY_NPAGE)) {
+			/* Remove highligt of current item */
+			print_item(scroll + choice, choice, FALSE);
+
+			if (key == KEY_UP || key == '-') {
+				if (choice < 2 && scroll) {
+					/* Scroll menu down */
+					do_scroll(menu, &scroll, -1);
+
+					print_item(scroll, 0, FALSE);
+				} else
+					choice = MAX(choice - 1, 0);
+
+			} else if (key == KEY_DOWN || key == '+') {
+				print_item(scroll+choice, choice, FALSE);
+
+				if ((choice > max_choice - 3) &&
+				    (scroll + max_choice < item_count())) {
+					/* Scroll menu up */
+					do_scroll(menu, &scroll, 1);
+
+					print_item(scroll+max_choice - 1,
+						   max_choice - 1, FALSE);
+				} else
+					choice = MIN(choice + 1, max_choice - 1);
+
+			} else if (key == KEY_PPAGE) {
+				scrollok(menu, TRUE);
+				for (i = 0; (i < max_choice); i++) {
+					if (scroll > 0) {
+						do_scroll(menu, &scroll, -1);
+						print_item(scroll, 0, FALSE);
+					} else {
+						if (choice > 0)
+							choice--;
+					}
+				}
+
+			} else if (key == KEY_NPAGE) {
+				for (i = 0; (i < max_choice); i++) {
+					if (scroll + max_choice < item_count()) {
+						do_scroll(menu, &scroll, 1);
+						print_item(scroll+max_choice-1,
+							   max_choice - 1, FALSE);
+					} else {
+						if (choice + 1 < max_choice)
+							choice++;
+					}
+				}
+			} else
+				choice = i;
+
+			print_item(scroll + choice, choice, TRUE);
+
+			print_arrows(dialog, item_count(), scroll,
+				     box_y, box_x + item_x + 1, menu_height);
+
+			wnoutrefresh(dialog);
+			wrefresh(menu);
+
+			continue;	/* wait for another key press */
+		}
+
+		switch (key) {
+		case KEY_LEFT:
+		case TAB:
+		case KEY_RIGHT:
+			button = ((key == KEY_LEFT ? --button : ++button) < 0)
+			    ? 4 : (button > 4 ? 0 : button);
+
+			print_buttons(dialog, height, width, button);
+			wrefresh(menu);
+			break;
+		case ' ':
+		case 's':
+		case 'y':
+		case 'n':
+		case 'm':
+		case '/':
+		case 'h':
+		case '?':
+		case 'z':
+		case '\n':
+			/* save scroll info */
+			*s_scroll = scroll;
+			delwin(menu);
+			delwin(dialog);
+			item_set(scroll + choice);
+			item_set_selected(1);
+			switch (key) {
+			case 'h':
+			case '?':
+				return 2;
+			case 's':
+			case 'y':
+				return 5;
+			case 'n':
+				return 6;
+			case 'm':
+				return 7;
+			case ' ':
+				return 8;
+			case '/':
+				return 9;
+			case 'z':
+				return 10;
+			case '\n':
+				return button;
+			}
+			return 0;
+		case 'e':
+		case 'x':
+			key = KEY_ESC;
+			break;
+		case KEY_ESC:
+			key = on_key_esc(menu);
+			break;
+		case KEY_RESIZE:
+			on_key_resize();
+			delwin(menu);
+			delwin(dialog);
+			goto do_resize;
+		}
+	}
+	delwin(menu);
+	delwin(dialog);
+	return key;		/* ESC pressed */
+}
diff --git a/backport/kconf/lxdialog/textbox.c b/backport/kconf/lxdialog/textbox.c
new file mode 100644
index 000000000000..4e339b12664e
--- /dev/null
+++ b/backport/kconf/lxdialog/textbox.c
@@ -0,0 +1,395 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ *  textbox.c -- implements the text box
+ *
+ *  ORIGINAL AUTHOR: Savio Lam (lam836@cs.cuhk.hk)
+ *  MODIFIED FOR LINUX KERNEL CONFIG BY: William Roadcap (roadcap@cfw.com)
+ */
+
+#include "dialog.h"
+
+static void back_lines(int n);
+static void print_page(WINDOW *win, int height, int width, update_text_fn
+		       update_text, void *data);
+static void print_line(WINDOW *win, int row, int width);
+static char *get_line(void);
+static void print_position(WINDOW * win);
+
+static int hscroll;
+static int begin_reached, end_reached, page_length;
+static char *buf;
+static char *page;
+
+/*
+ * refresh window content
+ */
+static void refresh_text_box(WINDOW *dialog, WINDOW *box, int boxh, int boxw,
+			     int cur_y, int cur_x, update_text_fn update_text,
+			     void *data)
+{
+	print_page(box, boxh, boxw, update_text, data);
+	print_position(dialog);
+	wmove(dialog, cur_y, cur_x);	/* Restore cursor position */
+	wrefresh(dialog);
+}
+
+
+/*
+ * Display text from a file in a dialog box.
+ *
+ * keys is a null-terminated array
+ * update_text() may not add or remove any '\n' or '\0' in tbuf
+ */
+int dialog_textbox(const char *title, char *tbuf, int initial_height,
+		   int initial_width, int *keys, int *_vscroll, int *_hscroll,
+		   update_text_fn update_text, void *data)
+{
+	int i, x, y, cur_x, cur_y, key = 0;
+	int height, width, boxh, boxw;
+	WINDOW *dialog, *box;
+	bool done = false;
+
+	begin_reached = 1;
+	end_reached = 0;
+	page_length = 0;
+	hscroll = 0;
+	buf = tbuf;
+	page = buf;	/* page is pointer to start of page to be displayed */
+
+	if (_vscroll && *_vscroll) {
+		begin_reached = 0;
+
+		for (i = 0; i < *_vscroll; i++)
+			get_line();
+	}
+	if (_hscroll)
+		hscroll = *_hscroll;
+
+do_resize:
+	getmaxyx(stdscr, height, width);
+	if (height < TEXTBOX_HEIGTH_MIN || width < TEXTBOX_WIDTH_MIN)
+		return -ERRDISPLAYTOOSMALL;
+	if (initial_height != 0)
+		height = initial_height;
+	else
+		if (height > 4)
+			height -= 4;
+		else
+			height = 0;
+	if (initial_width != 0)
+		width = initial_width;
+	else
+		if (width > 5)
+			width -= 5;
+		else
+			width = 0;
+
+	/* center dialog box on screen */
+	x = (getmaxx(stdscr) - width) / 2;
+	y = (getmaxy(stdscr) - height) / 2;
+
+	draw_shadow(stdscr, y, x, height, width);
+
+	dialog = newwin(height, width, y, x);
+	keypad(dialog, TRUE);
+
+	/* Create window for box region, used for scrolling text */
+	boxh = height - 4;
+	boxw = width - 2;
+	box = subwin(dialog, boxh, boxw, y + 1, x + 1);
+	wattrset(box, dlg.dialog.atr);
+	wbkgdset(box, dlg.dialog.atr & A_COLOR);
+
+	keypad(box, TRUE);
+
+	/* register the new window, along with its borders */
+	draw_box(dialog, 0, 0, height, width,
+		 dlg.dialog.atr, dlg.border.atr);
+
+	wattrset(dialog, dlg.border.atr);
+	mvwaddch(dialog, height - 3, 0, ACS_LTEE);
+	for (i = 0; i < width - 2; i++)
+		waddch(dialog, ACS_HLINE);
+	wattrset(dialog, dlg.dialog.atr);
+	wbkgdset(dialog, dlg.dialog.atr & A_COLOR);
+	waddch(dialog, ACS_RTEE);
+
+	print_title(dialog, title, width);
+
+	print_button(dialog, " Exit ", height - 2, width / 2 - 4, TRUE);
+	wnoutrefresh(dialog);
+	getyx(dialog, cur_y, cur_x);	/* Save cursor position */
+
+	/* Print first page of text */
+	attr_clear(box, boxh, boxw, dlg.dialog.atr);
+	refresh_text_box(dialog, box, boxh, boxw, cur_y, cur_x, update_text,
+			 data);
+
+	while (!done) {
+		key = wgetch(dialog);
+		switch (key) {
+		case 'E':	/* Exit */
+		case 'e':
+		case 'X':
+		case 'x':
+		case 'q':
+		case '\n':
+			done = true;
+			break;
+		case 'g':	/* First page */
+		case KEY_HOME:
+			if (!begin_reached) {
+				begin_reached = 1;
+				page = buf;
+				refresh_text_box(dialog, box, boxh, boxw,
+						 cur_y, cur_x, update_text,
+						 data);
+			}
+			break;
+		case 'G':	/* Last page */
+		case KEY_END:
+
+			end_reached = 1;
+			/* point to last char in buf */
+			page = buf + strlen(buf);
+			back_lines(boxh);
+			refresh_text_box(dialog, box, boxh, boxw, cur_y,
+					 cur_x, update_text, data);
+			break;
+		case 'K':	/* Previous line */
+		case 'k':
+		case KEY_UP:
+			if (begin_reached)
+				break;
+
+			back_lines(page_length + 1);
+			refresh_text_box(dialog, box, boxh, boxw, cur_y,
+					 cur_x, update_text, data);
+			break;
+		case 'B':	/* Previous page */
+		case 'b':
+		case 'u':
+		case KEY_PPAGE:
+			if (begin_reached)
+				break;
+			back_lines(page_length + boxh);
+			refresh_text_box(dialog, box, boxh, boxw, cur_y,
+					 cur_x, update_text, data);
+			break;
+		case 'J':	/* Next line */
+		case 'j':
+		case KEY_DOWN:
+			if (end_reached)
+				break;
+
+			back_lines(page_length - 1);
+			refresh_text_box(dialog, box, boxh, boxw, cur_y,
+					 cur_x, update_text, data);
+			break;
+		case KEY_NPAGE:	/* Next page */
+		case ' ':
+		case 'd':
+			if (end_reached)
+				break;
+
+			begin_reached = 0;
+			refresh_text_box(dialog, box, boxh, boxw, cur_y,
+					 cur_x, update_text, data);
+			break;
+		case '0':	/* Beginning of line */
+		case 'H':	/* Scroll left */
+		case 'h':
+		case KEY_LEFT:
+			if (hscroll <= 0)
+				break;
+
+			if (key == '0')
+				hscroll = 0;
+			else
+				hscroll--;
+			/* Reprint current page to scroll horizontally */
+			back_lines(page_length);
+			refresh_text_box(dialog, box, boxh, boxw, cur_y,
+					 cur_x, update_text, data);
+			break;
+		case 'L':	/* Scroll right */
+		case 'l':
+		case KEY_RIGHT:
+			if (hscroll >= MAX_LEN)
+				break;
+			hscroll++;
+			/* Reprint current page to scroll horizontally */
+			back_lines(page_length);
+			refresh_text_box(dialog, box, boxh, boxw, cur_y,
+					 cur_x, update_text, data);
+			break;
+		case KEY_ESC:
+			if (on_key_esc(dialog) == KEY_ESC)
+				done = true;
+			break;
+		case KEY_RESIZE:
+			back_lines(height);
+			delwin(box);
+			delwin(dialog);
+			on_key_resize();
+			goto do_resize;
+		default:
+			for (i = 0; keys[i]; i++) {
+				if (key == keys[i]) {
+					done = true;
+					break;
+				}
+			}
+		}
+	}
+	delwin(box);
+	delwin(dialog);
+	if (_vscroll) {
+		const char *s;
+
+		s = buf;
+		*_vscroll = 0;
+		back_lines(page_length);
+		while (s < page && (s = strchr(s, '\n'))) {
+			(*_vscroll)++;
+			s++;
+		}
+	}
+	if (_hscroll)
+		*_hscroll = hscroll;
+	return key;
+}
+
+/*
+ * Go back 'n' lines in text. Called by dialog_textbox().
+ * 'page' will be updated to point to the desired line in 'buf'.
+ */
+static void back_lines(int n)
+{
+	int i;
+
+	begin_reached = 0;
+	/* Go back 'n' lines */
+	for (i = 0; i < n; i++) {
+		if (*page == '\0') {
+			if (end_reached) {
+				end_reached = 0;
+				continue;
+			}
+		}
+		if (page == buf) {
+			begin_reached = 1;
+			return;
+		}
+		page--;
+		do {
+			if (page == buf) {
+				begin_reached = 1;
+				return;
+			}
+			page--;
+		} while (*page != '\n');
+		page++;
+	}
+}
+
+/*
+ * Print a new page of text.
+ */
+static void print_page(WINDOW *win, int height, int width, update_text_fn
+		       update_text, void *data)
+{
+	int i, passed_end = 0;
+
+	if (update_text) {
+		char *end;
+
+		for (i = 0; i < height; i++)
+			get_line();
+		end = page;
+		back_lines(height);
+		update_text(buf, page - buf, end - buf, data);
+	}
+
+	page_length = 0;
+	for (i = 0; i < height; i++) {
+		print_line(win, i, width);
+		if (!passed_end)
+			page_length++;
+		if (end_reached && !passed_end)
+			passed_end = 1;
+	}
+	wnoutrefresh(win);
+}
+
+/*
+ * Print a new line of text.
+ */
+static void print_line(WINDOW * win, int row, int width)
+{
+	char *line;
+
+	line = get_line();
+	line += MIN(strlen(line), hscroll);	/* Scroll horizontally */
+	wmove(win, row, 0);	/* move cursor to correct line */
+	waddch(win, ' ');
+	waddnstr(win, line, MIN(strlen(line), width - 2));
+
+	/* Clear 'residue' of previous line */
+#if OLD_NCURSES
+	{
+		int x = getcurx(win);
+		int i;
+		for (i = 0; i < width - x; i++)
+			waddch(win, ' ');
+	}
+#else
+	wclrtoeol(win);
+#endif
+}
+
+/*
+ * Return current line of text. Called by dialog_textbox() and print_line().
+ * 'page' should point to start of current line before calling, and will be
+ * updated to point to start of next line.
+ */
+static char *get_line(void)
+{
+	int i = 0;
+	static char line[MAX_LEN + 1];
+
+	end_reached = 0;
+	while (*page != '\n') {
+		if (*page == '\0') {
+			end_reached = 1;
+			break;
+		} else if (i < MAX_LEN)
+			line[i++] = *(page++);
+		else {
+			/* Truncate lines longer than MAX_LEN characters */
+			if (i == MAX_LEN)
+				line[i++] = '\0';
+			page++;
+		}
+	}
+	if (i <= MAX_LEN)
+		line[i] = '\0';
+	if (!end_reached)
+		page++;		/* move past '\n' */
+
+	return line;
+}
+
+/*
+ * Print current position
+ */
+static void print_position(WINDOW * win)
+{
+	int percent;
+
+	wattrset(win, dlg.position_indicator.atr);
+	wbkgdset(win, dlg.position_indicator.atr & A_COLOR);
+	percent = (page - buf) * 100 / strlen(buf);
+	wmove(win, getmaxy(win) - 3, getmaxx(win) - 9);
+	wprintw(win, "(%3d%%)", percent);
+}
diff --git a/backport/kconf/lxdialog/util.c b/backport/kconf/lxdialog/util.c
new file mode 100644
index 000000000000..3f78fb265136
--- /dev/null
+++ b/backport/kconf/lxdialog/util.c
@@ -0,0 +1,700 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ *  util.c
+ *
+ *  ORIGINAL AUTHOR: Savio Lam (lam836@cs.cuhk.hk)
+ *  MODIFIED FOR LINUX KERNEL CONFIG BY: William Roadcap (roadcap@cfw.com)
+ */
+
+#include <stdarg.h>
+
+#include "dialog.h"
+
+/* Needed in signal handler in mconf.c */
+int saved_x, saved_y;
+
+struct dialog_info dlg;
+
+static void set_mono_theme(void)
+{
+	dlg.screen.atr = A_NORMAL;
+	dlg.shadow.atr = A_NORMAL;
+	dlg.dialog.atr = A_NORMAL;
+	dlg.title.atr = A_BOLD;
+	dlg.border.atr = A_NORMAL;
+	dlg.button_active.atr = A_REVERSE;
+	dlg.button_inactive.atr = A_DIM;
+	dlg.button_key_active.atr = A_REVERSE;
+	dlg.button_key_inactive.atr = A_BOLD;
+	dlg.button_label_active.atr = A_REVERSE;
+	dlg.button_label_inactive.atr = A_NORMAL;
+	dlg.inputbox.atr = A_NORMAL;
+	dlg.inputbox_border.atr = A_NORMAL;
+	dlg.searchbox.atr = A_NORMAL;
+	dlg.searchbox_title.atr = A_BOLD;
+	dlg.searchbox_border.atr = A_NORMAL;
+	dlg.position_indicator.atr = A_BOLD;
+	dlg.menubox.atr = A_NORMAL;
+	dlg.menubox_border.atr = A_NORMAL;
+	dlg.item.atr = A_NORMAL;
+	dlg.item_selected.atr = A_REVERSE;
+	dlg.tag.atr = A_BOLD;
+	dlg.tag_selected.atr = A_REVERSE;
+	dlg.tag_key.atr = A_BOLD;
+	dlg.tag_key_selected.atr = A_REVERSE;
+	dlg.check.atr = A_BOLD;
+	dlg.check_selected.atr = A_REVERSE;
+	dlg.uarrow.atr = A_BOLD;
+	dlg.darrow.atr = A_BOLD;
+}
+
+#define DLG_COLOR(dialog, f, b, h) \
+do {                               \
+	dlg.dialog.fg = (f);       \
+	dlg.dialog.bg = (b);       \
+	dlg.dialog.hl = (h);       \
+} while (0)
+
+static void set_classic_theme(void)
+{
+	DLG_COLOR(screen,                COLOR_CYAN,   COLOR_BLUE,   true);
+	DLG_COLOR(shadow,                COLOR_BLACK,  COLOR_BLACK,  true);
+	DLG_COLOR(dialog,                COLOR_BLACK,  COLOR_WHITE,  false);
+	DLG_COLOR(title,                 COLOR_YELLOW, COLOR_WHITE,  true);
+	DLG_COLOR(border,                COLOR_WHITE,  COLOR_WHITE,  true);
+	DLG_COLOR(button_active,         COLOR_WHITE,  COLOR_BLUE,   true);
+	DLG_COLOR(button_inactive,       COLOR_BLACK,  COLOR_WHITE,  false);
+	DLG_COLOR(button_key_active,     COLOR_WHITE,  COLOR_BLUE,   true);
+	DLG_COLOR(button_key_inactive,   COLOR_RED,    COLOR_WHITE,  false);
+	DLG_COLOR(button_label_active,   COLOR_YELLOW, COLOR_BLUE,   true);
+	DLG_COLOR(button_label_inactive, COLOR_BLACK,  COLOR_WHITE,  true);
+	DLG_COLOR(inputbox,              COLOR_BLACK,  COLOR_WHITE,  false);
+	DLG_COLOR(inputbox_border,       COLOR_BLACK,  COLOR_WHITE,  false);
+	DLG_COLOR(searchbox,             COLOR_BLACK,  COLOR_WHITE,  false);
+	DLG_COLOR(searchbox_title,       COLOR_YELLOW, COLOR_WHITE,  true);
+	DLG_COLOR(searchbox_border,      COLOR_WHITE,  COLOR_WHITE,  true);
+	DLG_COLOR(position_indicator,    COLOR_YELLOW, COLOR_WHITE,  true);
+	DLG_COLOR(menubox,               COLOR_BLACK,  COLOR_WHITE,  false);
+	DLG_COLOR(menubox_border,        COLOR_WHITE,  COLOR_WHITE,  true);
+	DLG_COLOR(item,                  COLOR_BLACK,  COLOR_WHITE,  false);
+	DLG_COLOR(item_selected,         COLOR_WHITE,  COLOR_BLUE,   true);
+	DLG_COLOR(tag,                   COLOR_YELLOW, COLOR_WHITE,  true);
+	DLG_COLOR(tag_selected,          COLOR_YELLOW, COLOR_BLUE,   true);
+	DLG_COLOR(tag_key,               COLOR_YELLOW, COLOR_WHITE,  true);
+	DLG_COLOR(tag_key_selected,      COLOR_YELLOW, COLOR_BLUE,   true);
+	DLG_COLOR(check,                 COLOR_BLACK,  COLOR_WHITE,  false);
+	DLG_COLOR(check_selected,        COLOR_WHITE,  COLOR_BLUE,   true);
+	DLG_COLOR(uarrow,                COLOR_GREEN,  COLOR_WHITE,  true);
+	DLG_COLOR(darrow,                COLOR_GREEN,  COLOR_WHITE,  true);
+}
+
+static void set_blackbg_theme(void)
+{
+	DLG_COLOR(screen, COLOR_RED,   COLOR_BLACK, true);
+	DLG_COLOR(shadow, COLOR_BLACK, COLOR_BLACK, false);
+	DLG_COLOR(dialog, COLOR_WHITE, COLOR_BLACK, false);
+	DLG_COLOR(title,  COLOR_RED,   COLOR_BLACK, false);
+	DLG_COLOR(border, COLOR_BLACK, COLOR_BLACK, true);
+
+	DLG_COLOR(button_active,         COLOR_YELLOW, COLOR_RED,   false);
+	DLG_COLOR(button_inactive,       COLOR_YELLOW, COLOR_BLACK, false);
+	DLG_COLOR(button_key_active,     COLOR_YELLOW, COLOR_RED,   true);
+	DLG_COLOR(button_key_inactive,   COLOR_RED,    COLOR_BLACK, false);
+	DLG_COLOR(button_label_active,   COLOR_WHITE,  COLOR_RED,   false);
+	DLG_COLOR(button_label_inactive, COLOR_BLACK,  COLOR_BLACK, true);
+
+	DLG_COLOR(inputbox,         COLOR_YELLOW, COLOR_BLACK, false);
+	DLG_COLOR(inputbox_border,  COLOR_YELLOW, COLOR_BLACK, false);
+
+	DLG_COLOR(searchbox,        COLOR_YELLOW, COLOR_BLACK, false);
+	DLG_COLOR(searchbox_title,  COLOR_YELLOW, COLOR_BLACK, true);
+	DLG_COLOR(searchbox_border, COLOR_BLACK,  COLOR_BLACK, true);
+
+	DLG_COLOR(position_indicator, COLOR_RED, COLOR_BLACK,  false);
+
+	DLG_COLOR(menubox,          COLOR_YELLOW, COLOR_BLACK, false);
+	DLG_COLOR(menubox_border,   COLOR_BLACK,  COLOR_BLACK, true);
+
+	DLG_COLOR(item,             COLOR_WHITE, COLOR_BLACK, false);
+	DLG_COLOR(item_selected,    COLOR_WHITE, COLOR_RED,   false);
+
+	DLG_COLOR(tag,              COLOR_RED,    COLOR_BLACK, false);
+	DLG_COLOR(tag_selected,     COLOR_YELLOW, COLOR_RED,   true);
+	DLG_COLOR(tag_key,          COLOR_RED,    COLOR_BLACK, false);
+	DLG_COLOR(tag_key_selected, COLOR_YELLOW, COLOR_RED,   true);
+
+	DLG_COLOR(check,            COLOR_YELLOW, COLOR_BLACK, false);
+	DLG_COLOR(check_selected,   COLOR_YELLOW, COLOR_RED,   true);
+
+	DLG_COLOR(uarrow, COLOR_RED, COLOR_BLACK, false);
+	DLG_COLOR(darrow, COLOR_RED, COLOR_BLACK, false);
+}
+
+static void set_bluetitle_theme(void)
+{
+	set_classic_theme();
+	DLG_COLOR(title,               COLOR_BLUE,   COLOR_WHITE, true);
+	DLG_COLOR(button_key_active,   COLOR_YELLOW, COLOR_BLUE,  true);
+	DLG_COLOR(button_label_active, COLOR_WHITE,  COLOR_BLUE,  true);
+	DLG_COLOR(searchbox_title,     COLOR_BLUE,   COLOR_WHITE, true);
+	DLG_COLOR(position_indicator,  COLOR_BLUE,   COLOR_WHITE, true);
+	DLG_COLOR(tag,                 COLOR_BLUE,   COLOR_WHITE, true);
+	DLG_COLOR(tag_key,             COLOR_BLUE,   COLOR_WHITE, true);
+
+}
+
+/*
+ * Select color theme
+ */
+static int set_theme(const char *theme)
+{
+	int use_color = 1;
+	if (!theme)
+		set_bluetitle_theme();
+	else if (strcmp(theme, "classic") == 0)
+		set_classic_theme();
+	else if (strcmp(theme, "bluetitle") == 0)
+		set_bluetitle_theme();
+	else if (strcmp(theme, "blackbg") == 0)
+		set_blackbg_theme();
+	else if (strcmp(theme, "mono") == 0)
+		use_color = 0;
+
+	return use_color;
+}
+
+static void init_one_color(struct dialog_color *color)
+{
+	static int pair = 0;
+
+	pair++;
+	init_pair(pair, color->fg, color->bg);
+	if (color->hl)
+		color->atr = A_BOLD | COLOR_PAIR(pair);
+	else
+		color->atr = COLOR_PAIR(pair);
+}
+
+static void init_dialog_colors(void)
+{
+	init_one_color(&dlg.screen);
+	init_one_color(&dlg.shadow);
+	init_one_color(&dlg.dialog);
+	init_one_color(&dlg.title);
+	init_one_color(&dlg.border);
+	init_one_color(&dlg.button_active);
+	init_one_color(&dlg.button_inactive);
+	init_one_color(&dlg.button_key_active);
+	init_one_color(&dlg.button_key_inactive);
+	init_one_color(&dlg.button_label_active);
+	init_one_color(&dlg.button_label_inactive);
+	init_one_color(&dlg.inputbox);
+	init_one_color(&dlg.inputbox_border);
+	init_one_color(&dlg.searchbox);
+	init_one_color(&dlg.searchbox_title);
+	init_one_color(&dlg.searchbox_border);
+	init_one_color(&dlg.position_indicator);
+	init_one_color(&dlg.menubox);
+	init_one_color(&dlg.menubox_border);
+	init_one_color(&dlg.item);
+	init_one_color(&dlg.item_selected);
+	init_one_color(&dlg.tag);
+	init_one_color(&dlg.tag_selected);
+	init_one_color(&dlg.tag_key);
+	init_one_color(&dlg.tag_key_selected);
+	init_one_color(&dlg.check);
+	init_one_color(&dlg.check_selected);
+	init_one_color(&dlg.uarrow);
+	init_one_color(&dlg.darrow);
+}
+
+/*
+ * Setup for color display
+ */
+static void color_setup(const char *theme)
+{
+	int use_color;
+
+	use_color = set_theme(theme);
+	if (use_color && has_colors()) {
+		start_color();
+		init_dialog_colors();
+	} else
+		set_mono_theme();
+}
+
+/*
+ * Set window to attribute 'attr'
+ */
+void attr_clear(WINDOW * win, int height, int width, chtype attr)
+{
+	int i, j;
+
+	wattrset(win, attr);
+	for (i = 0; i < height; i++) {
+		wmove(win, i, 0);
+		for (j = 0; j < width; j++)
+			waddch(win, ' ');
+	}
+	touchwin(win);
+}
+
+void dialog_clear(void)
+{
+	int lines, columns;
+
+	lines = getmaxy(stdscr);
+	columns = getmaxx(stdscr);
+
+	attr_clear(stdscr, lines, columns, dlg.screen.atr);
+	/* Display background title if it exists ... - SLH */
+	if (dlg.backtitle != NULL) {
+		int i, len = 0, skip = 0;
+		struct subtitle_list *pos;
+
+		wattrset(stdscr, dlg.screen.atr);
+		mvwaddstr(stdscr, 0, 1, (char *)dlg.backtitle);
+
+		for (pos = dlg.subtitles; pos != NULL; pos = pos->next) {
+			/* 3 is for the arrow and spaces */
+			len += strlen(pos->text) + 3;
+		}
+
+		wmove(stdscr, 1, 1);
+		if (len > columns - 2) {
+			const char *ellipsis = "[...] ";
+			waddstr(stdscr, ellipsis);
+			skip = len - (columns - 2 - strlen(ellipsis));
+		}
+
+		for (pos = dlg.subtitles; pos != NULL; pos = pos->next) {
+			if (skip == 0)
+				waddch(stdscr, ACS_RARROW);
+			else
+				skip--;
+
+			if (skip == 0)
+				waddch(stdscr, ' ');
+			else
+				skip--;
+
+			if (skip < strlen(pos->text)) {
+				waddstr(stdscr, pos->text + skip);
+				skip = 0;
+			} else
+				skip -= strlen(pos->text);
+
+			if (skip == 0)
+				waddch(stdscr, ' ');
+			else
+				skip--;
+		}
+
+		for (i = len + 1; i < columns - 1; i++)
+			waddch(stdscr, ACS_HLINE);
+	}
+	wnoutrefresh(stdscr);
+}
+
+/*
+ * Do some initialization for dialog
+ */
+int init_dialog(const char *backtitle)
+{
+	int height, width;
+
+	initscr();		/* Init curses */
+
+	/* Get current cursor position for signal handler in mconf.c */
+	getyx(stdscr, saved_y, saved_x);
+
+	getmaxyx(stdscr, height, width);
+	if (height < WINDOW_HEIGTH_MIN || width < WINDOW_WIDTH_MIN) {
+		endwin();
+		return -ERRDISPLAYTOOSMALL;
+	}
+
+	dlg.backtitle = backtitle;
+	color_setup(getenv("MENUCONFIG_COLOR"));
+
+	keypad(stdscr, TRUE);
+	cbreak();
+	noecho();
+	dialog_clear();
+
+	return 0;
+}
+
+void set_dialog_backtitle(const char *backtitle)
+{
+	dlg.backtitle = backtitle;
+}
+
+void set_dialog_subtitles(struct subtitle_list *subtitles)
+{
+	dlg.subtitles = subtitles;
+}
+
+/*
+ * End using dialog functions.
+ */
+void end_dialog(int x, int y)
+{
+	/* move cursor back to original position */
+	move(y, x);
+	refresh();
+	endwin();
+}
+
+/* Print the title of the dialog. Center the title and truncate
+ * tile if wider than dialog (- 2 chars).
+ **/
+void print_title(WINDOW *dialog, const char *title, int width)
+{
+	if (title) {
+		int tlen = MIN(width - 2, strlen(title));
+		wattrset(dialog, dlg.title.atr);
+		mvwaddch(dialog, 0, (width - tlen) / 2 - 1, ' ');
+		mvwaddnstr(dialog, 0, (width - tlen)/2, title, tlen);
+		waddch(dialog, ' ');
+	}
+}
+
+/*
+ * Print a string of text in a window, automatically wrap around to the
+ * next line if the string is too long to fit on one line. Newline
+ * characters '\n' are properly processed.  We start on a new line
+ * if there is no room for at least 4 nonblanks following a double-space.
+ */
+void print_autowrap(WINDOW * win, const char *prompt, int width, int y, int x)
+{
+	int newl, cur_x, cur_y;
+	int prompt_len, room, wlen;
+	char tempstr[MAX_LEN + 1], *word, *sp, *sp2, *newline_separator = 0;
+
+	strcpy(tempstr, prompt);
+
+	prompt_len = strlen(tempstr);
+
+	if (prompt_len <= width - x * 2) {	/* If prompt is short */
+		wmove(win, y, (width - prompt_len) / 2);
+		waddstr(win, tempstr);
+	} else {
+		cur_x = x;
+		cur_y = y;
+		newl = 1;
+		word = tempstr;
+		while (word && *word) {
+			sp = strpbrk(word, "\n ");
+			if (sp && *sp == '\n')
+				newline_separator = sp;
+
+			if (sp)
+				*sp++ = 0;
+
+			/* Wrap to next line if either the word does not fit,
+			   or it is the first word of a new sentence, and it is
+			   short, and the next word does not fit. */
+			room = width - cur_x;
+			wlen = strlen(word);
+			if (wlen > room ||
+			    (newl && wlen < 4 && sp
+			     && wlen + 1 + strlen(sp) > room
+			     && (!(sp2 = strpbrk(sp, "\n "))
+				 || wlen + 1 + (sp2 - sp) > room))) {
+				cur_y++;
+				cur_x = x;
+			}
+			wmove(win, cur_y, cur_x);
+			waddstr(win, word);
+			getyx(win, cur_y, cur_x);
+
+			/* Move to the next line if the word separator was a newline */
+			if (newline_separator) {
+				cur_y++;
+				cur_x = x;
+				newline_separator = 0;
+			} else
+				cur_x++;
+
+			if (sp && *sp == ' ') {
+				cur_x++;	/* double space */
+				while (*++sp == ' ') ;
+				newl = 1;
+			} else
+				newl = 0;
+			word = sp;
+		}
+	}
+}
+
+/*
+ * Print a button
+ */
+void print_button(WINDOW * win, const char *label, int y, int x, int selected)
+{
+	int i, temp;
+
+	wmove(win, y, x);
+	wattrset(win, selected ? dlg.button_active.atr
+		 : dlg.button_inactive.atr);
+	waddstr(win, "<");
+	temp = strspn(label, " ");
+	label += temp;
+	wattrset(win, selected ? dlg.button_label_active.atr
+		 : dlg.button_label_inactive.atr);
+	for (i = 0; i < temp; i++)
+		waddch(win, ' ');
+	wattrset(win, selected ? dlg.button_key_active.atr
+		 : dlg.button_key_inactive.atr);
+	waddch(win, label[0]);
+	wattrset(win, selected ? dlg.button_label_active.atr
+		 : dlg.button_label_inactive.atr);
+	waddstr(win, (char *)label + 1);
+	wattrset(win, selected ? dlg.button_active.atr
+		 : dlg.button_inactive.atr);
+	waddstr(win, ">");
+	wmove(win, y, x + temp + 1);
+}
+
+/*
+ * Draw a rectangular box with line drawing characters
+ */
+void
+draw_box(WINDOW * win, int y, int x, int height, int width,
+	 chtype box, chtype border)
+{
+	int i, j;
+
+	wattrset(win, 0);
+	for (i = 0; i < height; i++) {
+		wmove(win, y + i, x);
+		for (j = 0; j < width; j++)
+			if (!i && !j)
+				waddch(win, border | ACS_ULCORNER);
+			else if (i == height - 1 && !j)
+				waddch(win, border | ACS_LLCORNER);
+			else if (!i && j == width - 1)
+				waddch(win, box | ACS_URCORNER);
+			else if (i == height - 1 && j == width - 1)
+				waddch(win, box | ACS_LRCORNER);
+			else if (!i)
+				waddch(win, border | ACS_HLINE);
+			else if (i == height - 1)
+				waddch(win, box | ACS_HLINE);
+			else if (!j)
+				waddch(win, border | ACS_VLINE);
+			else if (j == width - 1)
+				waddch(win, box | ACS_VLINE);
+			else
+				waddch(win, box | ' ');
+	}
+}
+
+/*
+ * Draw shadows along the right and bottom edge to give a more 3D look
+ * to the boxes
+ */
+void draw_shadow(WINDOW * win, int y, int x, int height, int width)
+{
+	int i;
+
+	if (has_colors()) {	/* Whether terminal supports color? */
+		wattrset(win, dlg.shadow.atr);
+		wmove(win, y + height, x + 2);
+		for (i = 0; i < width; i++)
+			waddch(win, winch(win) & A_CHARTEXT);
+		for (i = y + 1; i < y + height + 1; i++) {
+			wmove(win, i, x + width);
+			waddch(win, winch(win) & A_CHARTEXT);
+			waddch(win, winch(win) & A_CHARTEXT);
+		}
+		wnoutrefresh(win);
+	}
+}
+
+/*
+ *  Return the position of the first alphabetic character in a string.
+ */
+int first_alpha(const char *string, const char *exempt)
+{
+	int i, in_paren = 0, c;
+
+	for (i = 0; i < strlen(string); i++) {
+		c = tolower(string[i]);
+
+		if (strchr("<[(", c))
+			++in_paren;
+		if (strchr(">])", c) && in_paren > 0)
+			--in_paren;
+
+		if ((!in_paren) && isalpha(c) && strchr(exempt, c) == 0)
+			return i;
+	}
+
+	return 0;
+}
+
+/*
+ * ncurses uses ESC to detect escaped char sequences. This resutl in
+ * a small timeout before ESC is actually delivered to the application.
+ * lxdialog suggest <ESC> <ESC> which is correctly translated to two
+ * times esc. But then we need to ignore the second esc to avoid stepping
+ * out one menu too much. Filter away all escaped key sequences since
+ * keypad(FALSE) turn off ncurses support for escape sequences - and that's
+ * needed to make notimeout() do as expected.
+ */
+int on_key_esc(WINDOW *win)
+{
+	int key;
+	int key2;
+	int key3;
+
+	nodelay(win, TRUE);
+	keypad(win, FALSE);
+	key = wgetch(win);
+	key2 = wgetch(win);
+	do {
+		key3 = wgetch(win);
+	} while (key3 != ERR);
+	nodelay(win, FALSE);
+	keypad(win, TRUE);
+	if (key == KEY_ESC && key2 == ERR)
+		return KEY_ESC;
+	else if (key != ERR && key != KEY_ESC && key2 == ERR)
+		ungetch(key);
+
+	return -1;
+}
+
+/* redraw screen in new size */
+int on_key_resize(void)
+{
+	dialog_clear();
+	return KEY_RESIZE;
+}
+
+struct dialog_list *item_cur;
+struct dialog_list item_nil;
+struct dialog_list *item_head;
+
+void item_reset(void)
+{
+	struct dialog_list *p, *next;
+
+	for (p = item_head; p; p = next) {
+		next = p->next;
+		free(p);
+	}
+	item_head = NULL;
+	item_cur = &item_nil;
+}
+
+void item_make(const char *fmt, ...)
+{
+	va_list ap;
+	struct dialog_list *p = malloc(sizeof(*p));
+
+	if (item_head)
+		item_cur->next = p;
+	else
+		item_head = p;
+	item_cur = p;
+	memset(p, 0, sizeof(*p));
+
+	va_start(ap, fmt);
+	vsnprintf(item_cur->node.str, sizeof(item_cur->node.str), fmt, ap);
+	va_end(ap);
+}
+
+void item_add_str(const char *fmt, ...)
+{
+	va_list ap;
+	size_t avail;
+
+	avail = sizeof(item_cur->node.str) - strlen(item_cur->node.str);
+
+	va_start(ap, fmt);
+	vsnprintf(item_cur->node.str + strlen(item_cur->node.str),
+		  avail, fmt, ap);
+	item_cur->node.str[sizeof(item_cur->node.str) - 1] = '\0';
+	va_end(ap);
+}
+
+void item_set_tag(char tag)
+{
+	item_cur->node.tag = tag;
+}
+void item_set_data(void *ptr)
+{
+	item_cur->node.data = ptr;
+}
+
+void item_set_selected(int val)
+{
+	item_cur->node.selected = val;
+}
+
+int item_activate_selected(void)
+{
+	item_foreach()
+		if (item_is_selected())
+			return 1;
+	return 0;
+}
+
+void *item_data(void)
+{
+	return item_cur->node.data;
+}
+
+char item_tag(void)
+{
+	return item_cur->node.tag;
+}
+
+int item_count(void)
+{
+	int n = 0;
+	struct dialog_list *p;
+
+	for (p = item_head; p; p = p->next)
+		n++;
+	return n;
+}
+
+void item_set(int n)
+{
+	int i = 0;
+	item_foreach()
+		if (i++ == n)
+			return;
+}
+
+int item_n(void)
+{
+	int n = 0;
+	struct dialog_list *p;
+
+	for (p = item_head; p; p = p->next) {
+		if (p == item_cur)
+			return n;
+		n++;
+	}
+	return 0;
+}
+
+const char *item_str(void)
+{
+	return item_cur->node.str;
+}
+
+int item_is_selected(void)
+{
+	return (item_cur->node.selected != 0);
+}
+
+int item_is_tag(char tag)
+{
+	return (item_cur->node.tag == tag);
+}
diff --git a/backport/kconf/lxdialog/yesno.c b/backport/kconf/lxdialog/yesno.c
new file mode 100644
index 000000000000..bcaac9b7bab2
--- /dev/null
+++ b/backport/kconf/lxdialog/yesno.c
@@ -0,0 +1,101 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ *  yesno.c -- implements the yes/no box
+ *
+ *  ORIGINAL AUTHOR: Savio Lam (lam836@cs.cuhk.hk)
+ *  MODIFIED FOR LINUX KERNEL CONFIG BY: William Roadcap (roadcap@cfw.com)
+ */
+
+#include "dialog.h"
+
+/*
+ * Display termination buttons
+ */
+static void print_buttons(WINDOW * dialog, int height, int width, int selected)
+{
+	int x = width / 2 - 10;
+	int y = height - 2;
+
+	print_button(dialog, " Yes ", y, x, selected == 0);
+	print_button(dialog, "  No  ", y, x + 13, selected == 1);
+
+	wmove(dialog, y, x + 1 + 13 * selected);
+	wrefresh(dialog);
+}
+
+/*
+ * Display a dialog box with two buttons - Yes and No
+ */
+int dialog_yesno(const char *title, const char *prompt, int height, int width)
+{
+	int i, x, y, key = 0, button = 0;
+	WINDOW *dialog;
+
+do_resize:
+	if (getmaxy(stdscr) < (height + YESNO_HEIGTH_MIN))
+		return -ERRDISPLAYTOOSMALL;
+	if (getmaxx(stdscr) < (width + YESNO_WIDTH_MIN))
+		return -ERRDISPLAYTOOSMALL;
+
+	/* center dialog box on screen */
+	x = (getmaxx(stdscr) - width) / 2;
+	y = (getmaxy(stdscr) - height) / 2;
+
+	draw_shadow(stdscr, y, x, height, width);
+
+	dialog = newwin(height, width, y, x);
+	keypad(dialog, TRUE);
+
+	draw_box(dialog, 0, 0, height, width,
+		 dlg.dialog.atr, dlg.border.atr);
+	wattrset(dialog, dlg.border.atr);
+	mvwaddch(dialog, height - 3, 0, ACS_LTEE);
+	for (i = 0; i < width - 2; i++)
+		waddch(dialog, ACS_HLINE);
+	wattrset(dialog, dlg.dialog.atr);
+	waddch(dialog, ACS_RTEE);
+
+	print_title(dialog, title, width);
+
+	wattrset(dialog, dlg.dialog.atr);
+	print_autowrap(dialog, prompt, width - 2, 1, 3);
+
+	print_buttons(dialog, height, width, 0);
+
+	while (key != KEY_ESC) {
+		key = wgetch(dialog);
+		switch (key) {
+		case 'Y':
+		case 'y':
+			delwin(dialog);
+			return 0;
+		case 'N':
+		case 'n':
+			delwin(dialog);
+			return 1;
+
+		case TAB:
+		case KEY_LEFT:
+		case KEY_RIGHT:
+			button = ((key == KEY_LEFT ? --button : ++button) < 0) ? 1 : (button > 1 ? 0 : button);
+
+			print_buttons(dialog, height, width, button);
+			wrefresh(dialog);
+			break;
+		case ' ':
+		case '\n':
+			delwin(dialog);
+			return button;
+		case KEY_ESC:
+			key = on_key_esc(dialog);
+			break;
+		case KEY_RESIZE:
+			delwin(dialog);
+			on_key_resize();
+			goto do_resize;
+		}
+	}
+
+	delwin(dialog);
+	return key;		/* ESC pressed */
+}
diff --git a/backport/kconf/mconf-cfg.sh b/backport/kconf/mconf-cfg.sh
new file mode 100755
index 000000000000..b520e407a8eb
--- /dev/null
+++ b/backport/kconf/mconf-cfg.sh
@@ -0,0 +1,52 @@
+#!/bin/sh
+# SPDX-License-Identifier: GPL-2.0
+
+PKG="ncursesw"
+PKG2="ncurses"
+
+if [ -n "$(command -v pkg-config)" ]; then
+	if pkg-config --exists $PKG; then
+		echo cflags=\"$(pkg-config --cflags $PKG)\"
+		echo libs=\"$(pkg-config --libs $PKG)\"
+		exit 0
+	fi
+
+	if pkg-config --exists $PKG2; then
+		echo cflags=\"$(pkg-config --cflags $PKG2)\"
+		echo libs=\"$(pkg-config --libs $PKG2)\"
+		exit 0
+	fi
+fi
+
+# Check the default paths in case pkg-config is not installed.
+# (Even if it is installed, some distributions such as openSUSE cannot
+# find ncurses by pkg-config.)
+if [ -f /usr/include/ncursesw/ncurses.h ]; then
+	echo cflags=\"-D_GNU_SOURCE -I/usr/include/ncursesw\"
+	echo libs=\"-lncursesw\"
+	exit 0
+fi
+
+if [ -f /usr/include/ncurses/ncurses.h ]; then
+	echo cflags=\"-D_GNU_SOURCE -I/usr/include/ncurses\"
+	echo libs=\"-lncurses\"
+	exit 0
+fi
+
+# As a final fallback before giving up, check if $HOSTCC knows of a default
+# ncurses installation (e.g. from a vendor-specific sysroot).
+if echo '#include <ncurses.h>' | ${HOSTCC} -E - >/dev/null 2>&1; then
+	echo cflags=\"-D_GNU_SOURCE\"
+	echo libs=\"-lncurses\"
+	exit 0
+fi
+
+echo >&2 "*"
+echo >&2 "* Unable to find the ncurses package."
+echo >&2 "* Install ncurses (ncurses-devel or libncurses-dev"
+echo >&2 "* depending on your distribution)."
+echo >&2 "*"
+echo >&2 "* You may also need to install pkg-config to find the"
+echo >&2 "* ncurses installed in a non-default location."
+echo >&2 "*"
+exit 1
diff --git a/backport/kconf/mconf.c b/backport/kconf/mconf.c
new file mode 100644
index 000000000000..9d3cf510562f
--- /dev/null
+++ b/backport/kconf/mconf.c
@@ -0,0 +1,1037 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2002 Roman Zippel <zippel@linux-m68k.org>
+ *
+ * Introduced single menu mode (show all sub-menus in one large tree).
+ * 2002-11-06 Petr Baudis <pasky@ucw.cz>
+ *
+ * i18n, 2005, Arnaldo Carvalho de Melo <acme@conectiva.com.br>
+ */
+
+#include <ctype.h>
+#include <errno.h>
+#include <fcntl.h>
+#include <limits.h>
+#include <stdarg.h>
+#include <stdlib.h>
+#include <string.h>
+#include <strings.h>
+#include <signal.h>
+#include <unistd.h>
+
+#include "lkc.h"
+#include "lxdialog/dialog.h"
+
+#define JUMP_NB			9
+
+static const char mconf_readme[] =
+"Overview\n"
+"--------\n"
+"This interface lets you select features and parameters for the build.\n"
+"Features can either be built-in, modularized, or ignored. Parameters\n"
+"must be entered in as decimal or hexadecimal numbers or text.\n"
+"\n"
+"Menu items beginning with following braces represent features that\n"
+"  [ ] can be built in or removed\n"
+"  < > can be built in, modularized or removed\n"
+"  { } can be built in or modularized (selected by other feature)\n"
+"  - - are selected by other feature,\n"
+"while *, M or whitespace inside braces means to build in, build as\n"
+"a module or to exclude the feature respectively.\n"
+"\n"
+"To change any of these features, highlight it with the cursor\n"
+"keys and press <Y> to build it in, <M> to make it a module or\n"
+"<N> to remove it.  You may also press the <Space Bar> to cycle\n"
+"through the available options (i.e. Y->N->M->Y).\n"
+"\n"
+"Some additional keyboard hints:\n"
+"\n"
+"Menus\n"
+"----------\n"
+"o  Use the Up/Down arrow keys (cursor keys) to highlight the item you\n"
+"   wish to change or the submenu you wish to select and press <Enter>.\n"
+"   Submenus are designated by \"--->\", empty ones by \"----\".\n"
+"\n"
+"   Shortcut: Press the option's highlighted letter (hotkey).\n"
+"             Pressing a hotkey more than once will sequence\n"
+"             through all visible items which use that hotkey.\n"
+"\n"
+"   You may also use the <PAGE UP> and <PAGE DOWN> keys to scroll\n"
+"   unseen options into view.\n"
+"\n"
+"o  To exit a menu use the cursor keys to highlight the <Exit> button\n"
+"   and press <ENTER>.\n"
+"\n"
+"   Shortcut: Press <ESC><ESC> or <E> or <X> if there is no hotkey\n"
+"             using those letters.  You may press a single <ESC>, but\n"
+"             there is a delayed response which you may find annoying.\n"
+"\n"
+"   Also, the <TAB> and cursor keys will cycle between <Select>,\n"
+"   <Exit>, <Help>, <Save>, and <Load>.\n"
+"\n"
+"o  To get help with an item, use the cursor keys to highlight <Help>\n"
+"   and press <ENTER>.\n"
+"\n"
+"   Shortcut: Press <H> or <?>.\n"
+"\n"
+"o  To toggle the display of hidden options, press <Z>.\n"
+"\n"
+"\n"
+"Radiolists  (Choice lists)\n"
+"-----------\n"
+"o  Use the cursor keys to select the option you wish to set and press\n"
+"   <S> or the <SPACE BAR>.\n"
+"\n"
+"   Shortcut: Press the first letter of the option you wish to set then\n"
+"             press <S> or <SPACE BAR>.\n"
+"\n"
+"o  To see available help for the item, use the cursor keys to highlight\n"
+"   <Help> and Press <ENTER>.\n"
+"\n"
+"   Shortcut: Press <H> or <?>.\n"
+"\n"
+"   Also, the <TAB> and cursor keys will cycle between <Select> and\n"
+"   <Help>\n"
+"\n"
+"\n"
+"Data Entry\n"
+"-----------\n"
+"o  Enter the requested information and press <ENTER>\n"
+"   If you are entering hexadecimal values, it is not necessary to\n"
+"   add the '0x' prefix to the entry.\n"
+"\n"
+"o  For help, use the <TAB> or cursor keys to highlight the help option\n"
+"   and press <ENTER>.  You can try <TAB><H> as well.\n"
+"\n"
+"\n"
+"Text Box    (Help Window)\n"
+"--------\n"
+"o  Use the cursor keys to scroll up/down/left/right.  The VI editor\n"
+"   keys h,j,k,l function here as do <u>, <d>, <SPACE BAR> and <B> for\n"
+"   those who are familiar with less and lynx.\n"
+"\n"
+"o  Press <E>, <X>, <q>, <Enter> or <Esc><Esc> to exit.\n"
+"\n"
+"\n"
+"Alternate Configuration Files\n"
+"-----------------------------\n"
+"Menuconfig supports the use of alternate configuration files for\n"
+"those who, for various reasons, find it necessary to switch\n"
+"between different configurations.\n"
+"\n"
+"The <Save> button will let you save the current configuration to\n"
+"a file of your choosing.  Use the <Load> button to load a previously\n"
+"saved alternate configuration.\n"
+"\n"
+"Even if you don't use alternate configuration files, but you find\n"
+"during a Menuconfig session that you have completely messed up your\n"
+"settings, you may use the <Load> button to restore your previously\n"
+"saved settings from \".config\" without restarting Menuconfig.\n"
+"\n"
+"Other information\n"
+"-----------------\n"
+"If you use Menuconfig in an XTERM window, make sure you have your\n"
+"$TERM variable set to point to an xterm definition which supports\n"
+"color.  Otherwise, Menuconfig will look rather bad.  Menuconfig will\n"
+"not display correctly in an RXVT window because rxvt displays only one\n"
+"intensity of color, bright.\n"
+"\n"
+"Menuconfig will display larger menus on screens or xterms which are\n"
+"set to display more than the standard 25 row by 80 column geometry.\n"
+"In order for this to work, the \"stty size\" command must be able to\n"
+"display the screen's current row and column geometry.  I STRONGLY\n"
+"RECOMMEND that you make sure you do NOT have the shell variables\n"
+"LINES and COLUMNS exported into your environment.  Some distributions\n"
+"export those variables via /etc/profile.  Some ncurses programs can\n"
+"become confused when those variables (LINES & COLUMNS) don't reflect\n"
+"the true screen size.\n"
+"\n"
+"Optional personality available\n"
+"------------------------------\n"
+"If you prefer to have all of the options listed in a single menu,\n"
+"rather than the default multimenu hierarchy, run the menuconfig with\n"
+"MENUCONFIG_MODE environment variable set to single_menu. Example:\n"
+"\n"
+"make MENUCONFIG_MODE=single_menu menuconfig\n"
+"\n"
+"<Enter> will then unroll the appropriate category, or enfold it if it\n"
+"is already unrolled.\n"
+"\n"
+"Note that this mode can eventually be a little more CPU expensive\n"
+"(especially with a larger number of unrolled categories) than the\n"
+"default mode.\n"
+"\n"
+"Different color themes available\n"
+"--------------------------------\n"
+"It is possible to select different color themes using the variable\n"
+"MENUCONFIG_COLOR. To select a theme use:\n"
+"\n"
+"make MENUCONFIG_COLOR=<theme> menuconfig\n"
+"\n"
+"Available themes are\n"
+" mono       => selects colors suitable for monochrome displays\n"
+" blackbg    => selects a color scheme with black background\n"
+" classic    => theme with blue background. The classic look\n"
+" bluetitle  => an LCD friendly version of classic. (default)\n"
+"\n",
+menu_instructions[] =
+	"Arrow keys navigate the menu.  "
+	"<Enter> selects submenus ---> (or empty submenus ----).  "
+	"Highlighted letters are hotkeys.  "
+	"Pressing <Y> includes, <N> excludes, <M> modularizes features.  "
+	"Press <Esc><Esc> to exit, <?> for Help, </> for Search.  "
+	"Legend: [*] built-in  [ ] excluded  <M> module  < > module capable",
+radiolist_instructions[] =
+	"Use the arrow keys to navigate this window or "
+	"press the hotkey of the item you wish to select "
+	"followed by the <SPACE BAR>. "
+	"Press <?> for additional information about this option.",
+inputbox_instructions_int[] =
+	"Please enter a decimal value. "
+	"Fractions will not be accepted.  "
+	"Use the <TAB> key to move from the input field to the buttons below it.",
+inputbox_instructions_hex[] =
+	"Please enter a hexadecimal value. "
+	"Use the <TAB> key to move from the input field to the buttons below it.",
+inputbox_instructions_string[] =
+	"Please enter a string value. "
+	"Use the <TAB> key to move from the input field to the buttons below it.",
+setmod_text[] =
+	"This feature depends on another which has been configured as a module.\n"
+	"As a result, this feature will be built as a module.",
+load_config_text[] =
+	"Enter the name of the configuration file you wish to load.  "
+	"Accept the name shown to restore the configuration you "
+	"last retrieved.  Leave blank to abort.",
+load_config_help[] =
+	"\n"
+	"For various reasons, one may wish to keep several different\n"
+	"configurations available on a single machine.\n"
+	"\n"
+	"If you have saved a previous configuration in a file other than the\n"
+	"default one, entering its name here will allow you to modify that\n"
+	"configuration.\n"
+	"\n"
+	"If you are uncertain, then you have probably never used alternate\n"
+	"configuration files. You should therefore leave this blank to abort.\n",
+save_config_text[] =
+	"Enter a filename to which this configuration should be saved "
+	"as an alternate.  Leave blank to abort.",
+save_config_help[] =
+	"\n"
+	"For various reasons, one may wish to keep different configurations\n"
+	"available on a single machine.\n"
+	"\n"
+	"Entering a file name here will allow you to later retrieve, modify\n"
+	"and use the current configuration as an alternate to whatever\n"
+	"configuration options you have selected at that time.\n"
+	"\n"
+	"If you are uncertain what all this means then you should probably\n"
+	"leave this blank.\n",
+search_help[] =
+	"\n"
+	"Search for symbols and display their relations.\n"
+	"Regular expressions are allowed.\n"
+	"Example: search for \"^FOO\"\n"
+	"Result:\n"
+	"-----------------------------------------------------------------\n"
+	"Symbol: FOO [=m]\n"
+	"Type  : tristate\n"
+	"Prompt: Foo bus is used to drive the bar HW\n"
+	"  Location:\n"
+	"    -> Bus options (PCI, PCMCIA, EISA, ISA)\n"
+	"      -> PCI support (PCI [=y])\n"
+	"(1)     -> PCI access mode (<choice> [=y])\n"
+	"  Defined at drivers/pci/Kconfig:47\n"
+	"  Depends on: X86_LOCAL_APIC && X86_IO_APIC || IA64\n"
+	"  Selects: LIBCRC32\n"
+	"  Selected by: BAR [=n]\n"
+	"-----------------------------------------------------------------\n"
+	"o The line 'Type:' shows the type of the configuration option for\n"
+	"  this symbol (bool, tristate, string, ...)\n"
+	"o The line 'Prompt:' shows the text used in the menu structure for\n"
+	"  this symbol\n"
+	"o The 'Defined at' line tells at what file / line number the symbol\n"
+	"  is defined\n"
+	"o The 'Depends on:' line tells what symbols need to be defined for\n"
+	"  this symbol to be visible in the menu (selectable)\n"
+	"o The 'Location:' lines tells where in the menu structure this symbol\n"
+	"  is located\n"
+	"    A location followed by a [=y] indicates that this is a\n"
+	"    selectable menu item - and the current value is displayed inside\n"
+	"    brackets.\n"
+	"    Press the key in the (#) prefix to jump directly to that\n"
+	"    location. You will be returned to the current search results\n"
+	"    after exiting this new menu.\n"
+	"o The 'Selects:' line tells what symbols will be automatically\n"
+	"  selected if this symbol is selected (y or m)\n"
+	"o The 'Selected by' line tells what symbol has selected this symbol\n"
+	"\n"
+	"Only relevant lines are shown.\n"
+	"\n\n"
+	"Search examples:\n"
+	"Examples: USB	=> find all symbols containing USB\n"
+	"          ^USB => find all symbols starting with USB\n"
+	"          USB$ => find all symbols ending with USB\n"
+	"\n";
+
+static int indent;
+static struct menu *current_menu;
+static int child_count;
+static int single_menu_mode;
+static int show_all_options;
+static int save_and_exit;
+static int silent;
+
+static void conf(struct menu *menu, struct menu *active_menu);
+static void conf_choice(struct menu *menu);
+static void conf_string(struct menu *menu);
+static void conf_load(void);
+static void conf_save(void);
+static int show_textbox_ext(const char *title, char *text, int r, int c,
+			    int *keys, int *vscroll, int *hscroll,
+			    update_text_fn update_text, void *data);
+static void show_textbox(const char *title, const char *text, int r, int c);
+static void show_helptext(const char *title, const char *text);
+static void show_help(struct menu *menu);
+
+static char filename[PATH_MAX+1];
+static void set_config_filename(const char *config_filename)
+{
+	static char menu_backtitle[PATH_MAX+128];
+
+	snprintf(menu_backtitle, sizeof(menu_backtitle), "%s - %s",
+		 config_filename, rootmenu.prompt->text);
+	set_dialog_backtitle(menu_backtitle);
+
+	snprintf(filename, sizeof(filename), "%s", config_filename);
+}
+
+struct subtitle_part {
+	struct list_head entries;
+	const char *text;
+};
+static LIST_HEAD(trail);
+
+static struct subtitle_list *subtitles;
+static void set_subtitle(void)
+{
+	struct subtitle_part *sp;
+	struct subtitle_list *pos, *tmp;
+
+	for (pos = subtitles; pos != NULL; pos = tmp) {
+		tmp = pos->next;
+		free(pos);
+	}
+
+	subtitles = NULL;
+	list_for_each_entry(sp, &trail, entries) {
+		if (sp->text) {
+			if (pos) {
+				pos->next = xcalloc(1, sizeof(*pos));
+				pos = pos->next;
+			} else {
+				subtitles = pos = xcalloc(1, sizeof(*pos));
+			}
+			pos->text = sp->text;
+		}
+	}
+
+	set_dialog_subtitles(subtitles);
+}
+
+static void reset_subtitle(void)
+{
+	struct subtitle_list *pos, *tmp;
+
+	for (pos = subtitles; pos != NULL; pos = tmp) {
+		tmp = pos->next;
+		free(pos);
+	}
+	subtitles = NULL;
+	set_dialog_subtitles(subtitles);
+}
+
+struct search_data {
+	struct list_head *head;
+	struct menu **targets;
+	int *keys;
+};
+
+static void update_text(char *buf, size_t start, size_t end, void *_data)
+{
+	struct search_data *data = _data;
+	struct jump_key *pos;
+	int k = 0;
+
+	list_for_each_entry(pos, data->head, entries) {
+		if (pos->offset >= start && pos->offset < end) {
+			char header[4];
+
+			if (k < JUMP_NB) {
+				int key = '0' + (pos->index % JUMP_NB) + 1;
+
+				sprintf(header, "(%c)", key);
+				data->keys[k] = key;
+				data->targets[k] = pos->target;
+				k++;
+			} else {
+				sprintf(header, "   ");
+			}
+
+			memcpy(buf + pos->offset, header, sizeof(header) - 1);
+		}
+	}
+	data->keys[k] = 0;
+}
+
+static void search_conf(void)
+{
+	struct symbol **sym_arr;
+	struct gstr res;
+	struct gstr title;
+	char *dialog_input;
+	int dres, vscroll = 0, hscroll = 0;
+	bool again;
+	struct gstr sttext;
+	struct subtitle_part stpart;
+
+	title = str_new();
+	str_printf( &title, "Enter (sub)string or regexp to search for "
+			      "(with or without \"%s\")", CONFIG_);
+
+again:
+	dialog_clear();
+	dres = dialog_inputbox("Search Configuration Parameter",
+			      str_get(&title),
+			      10, 75, "");
+	switch (dres) {
+	case 0:
+		break;
+	case 1:
+		show_helptext("Search Configuration", search_help);
+		goto again;
+	default:
+		str_free(&title);
+		return;
+	}
+
+	/* strip the prefix if necessary */
+	dialog_input = dialog_input_result;
+	if (strncasecmp(dialog_input_result, CONFIG_, strlen(CONFIG_)) == 0)
+		dialog_input += strlen(CONFIG_);
+
+	sttext = str_new();
+	str_printf(&sttext, "Search (%s)", dialog_input_result);
+	stpart.text = str_get(&sttext);
+	list_add_tail(&stpart.entries, &trail);
+
+	sym_arr = sym_re_search(dialog_input);
+	do {
+		LIST_HEAD(head);
+		struct menu *targets[JUMP_NB];
+		int keys[JUMP_NB + 1], i;
+		struct search_data data = {
+			.head = &head,
+			.targets = targets,
+			.keys = keys,
+		};
+		struct jump_key *pos, *tmp;
+
+		res = get_relations_str(sym_arr, &head);
+		set_subtitle();
+		dres = show_textbox_ext("Search Results", (char *)
+					str_get(&res), 0, 0, keys, &vscroll,
+					&hscroll, &update_text, (void *)
+					&data);
+		again = false;
+		for (i = 0; i < JUMP_NB && keys[i]; i++)
+			if (dres == keys[i]) {
+				conf(targets[i]->parent, targets[i]);
+				again = true;
+			}
+		str_free(&res);
+		list_for_each_entry_safe(pos, tmp, &head, entries)
+			free(pos);
+	} while (again);
+	free(sym_arr);
+	str_free(&title);
+	list_del(trail.prev);
+	str_free(&sttext);
+}
+
+static void build_conf(struct menu *menu)
+{
+	struct symbol *sym;
+	struct property *prop;
+	struct menu *child;
+	int type, tmp, doint = 2;
+	tristate val;
+	char ch;
+	bool visible;
+
+	/*
+	 * note: menu_is_visible() has side effect that it will
+	 * recalc the value of the symbol.
+	 */
+	visible = menu_is_visible(menu);
+	if (show_all_options && !menu_has_prompt(menu))
+		return;
+	else if (!show_all_options && !visible)
+		return;
+
+	sym = menu->sym;
+	prop = menu->prompt;
+	if (!sym) {
+		if (prop && menu != current_menu) {
+			const char *prompt = menu_get_prompt(menu);
+			switch (prop->type) {
+			case P_MENU:
+				child_count++;
+				if (single_menu_mode) {
+					item_make("%s%*c%s",
+						  menu->data ? "-->" : "++>",
+						  indent + 1, ' ', prompt);
+				} else
+					item_make("   %*c%s  %s",
+						  indent + 1, ' ', prompt,
+						  menu_is_empty(menu) ? "----" : "--->");
+				item_set_tag('m');
+				item_set_data(menu);
+				if (single_menu_mode && menu->data)
+					goto conf_childs;
+				return;
+			case P_COMMENT:
+				if (prompt) {
+					child_count++;
+					item_make("   %*c*** %s ***", indent + 1, ' ', prompt);
+					item_set_tag(':');
+					item_set_data(menu);
+				}
+				break;
+			default:
+				if (prompt) {
+					child_count++;
+					item_make("---%*c%s", indent + 1, ' ', prompt);
+					item_set_tag(':');
+					item_set_data(menu);
+				}
+			}
+		} else
+			doint = 0;
+		goto conf_childs;
+	}
+
+	type = sym_get_type(sym);
+	if (sym_is_choice(sym)) {
+		struct symbol *def_sym = sym_get_choice_value(sym);
+		struct menu *def_menu = NULL;
+
+		child_count++;
+		for (child = menu->list; child; child = child->next) {
+			if (menu_is_visible(child) && child->sym == def_sym)
+				def_menu = child;
+		}
+
+		val = sym_get_tristate_value(sym);
+		if (sym_is_changeable(sym)) {
+			switch (type) {
+			case S_BOOLEAN:
+				item_make("[%c]", val == no ? ' ' : '*');
+				break;
+			case S_TRISTATE:
+				switch (val) {
+				case yes: ch = '*'; break;
+				case mod: ch = 'M'; break;
+				default:  ch = ' '; break;
+				}
+				item_make("<%c>", ch);
+				break;
+			}
+			item_set_tag('t');
+			item_set_data(menu);
+		} else {
+			item_make("   ");
+			item_set_tag(def_menu ? 't' : ':');
+			item_set_data(menu);
+		}
+
+		item_add_str("%*c%s", indent + 1, ' ', menu_get_prompt(menu));
+		if (val == yes) {
+			if (def_menu) {
+				item_add_str(" (%s)", menu_get_prompt(def_menu));
+				item_add_str("  --->");
+				if (def_menu->list) {
+					indent += 2;
+					build_conf(def_menu);
+					indent -= 2;
+				}
+			}
+			return;
+		}
+	} else {
+		if (menu == current_menu) {
+			item_make("---%*c%s", indent + 1, ' ', menu_get_prompt(menu));
+			item_set_tag(':');
+			item_set_data(menu);
+			goto conf_childs;
+		}
+		child_count++;
+		val = sym_get_tristate_value(sym);
+		if (sym_is_choice_value(sym) && val == yes) {
+			item_make("   ");
+			item_set_tag(':');
+			item_set_data(menu);
+		} else {
+			switch (type) {
+			case S_BOOLEAN:
+				if (sym_is_changeable(sym))
+					item_make("[%c]", val == no ? ' ' : '*');
+				else
+					item_make("-%c-", val == no ? ' ' : '*');
+				item_set_tag('t');
+				item_set_data(menu);
+				break;
+			case S_TRISTATE:
+				switch (val) {
+				case yes: ch = '*'; break;
+				case mod: ch = 'M'; break;
+				default:  ch = ' '; break;
+				}
+				if (sym_is_changeable(sym)) {
+					if (sym->rev_dep.tri == mod)
+						item_make("{%c}", ch);
+					else
+						item_make("<%c>", ch);
+				} else
+					item_make("-%c-", ch);
+				item_set_tag('t');
+				item_set_data(menu);
+				break;
+			default:
+				tmp = 2 + strlen(sym_get_string_value(sym)); /* () = 2 */
+				item_make("(%s)", sym_get_string_value(sym));
+				tmp = indent - tmp + 4;
+				if (tmp < 0)
+					tmp = 0;
+				item_add_str("%*c%s%s", tmp, ' ', menu_get_prompt(menu),
+					     (sym_has_value(sym) || !sym_is_changeable(sym)) ?
+					     "" : " (NEW)");
+				item_set_tag('s');
+				item_set_data(menu);
+				goto conf_childs;
+			}
+		}
+		item_add_str("%*c%s%s", indent + 1, ' ', menu_get_prompt(menu),
+			  (sym_has_value(sym) || !sym_is_changeable(sym)) ?
+			  "" : " (NEW)");
+		if (menu->prompt->type == P_MENU) {
+			item_add_str("  %s", menu_is_empty(menu) ? "----" : "--->");
+			return;
+		}
+	}
+
+conf_childs:
+	indent += doint;
+	for (child = menu->list; child; child = child->next)
+		build_conf(child);
+	indent -= doint;
+}
+
+static void conf(struct menu *menu, struct menu *active_menu)
+{
+	struct menu *submenu;
+	const char *prompt = menu_get_prompt(menu);
+	struct subtitle_part stpart;
+	struct symbol *sym;
+	int res;
+	int s_scroll = 0;
+
+	if (menu != &rootmenu)
+		stpart.text = menu_get_prompt(menu);
+	else
+		stpart.text = NULL;
+	list_add_tail(&stpart.entries, &trail);
+
+	while (1) {
+		item_reset();
+		current_menu = menu;
+		build_conf(menu);
+		if (!child_count)
+			break;
+		set_subtitle();
+		dialog_clear();
+		res = dialog_menu(prompt ? prompt : "Main Menu",
+				  menu_instructions,
+				  active_menu, &s_scroll);
+		if (res == 1 || res == KEY_ESC || res == -ERRDISPLAYTOOSMALL)
+			break;
+		if (item_count() != 0) {
+			if (!item_activate_selected())
+				continue;
+			if (!item_tag())
+				continue;
+		}
+		submenu = item_data();
+		active_menu = item_data();
+		if (submenu)
+			sym = submenu->sym;
+		else
+			sym = NULL;
+
+		switch (res) {
+		case 0:
+			switch (item_tag()) {
+			case 'm':
+				if (single_menu_mode)
+					submenu->data = (void *) (long) !submenu->data;
+				else
+					conf(submenu, NULL);
+				break;
+			case 't':
+				if (sym_is_choice(sym) && sym_get_tristate_value(sym) == yes)
+					conf_choice(submenu);
+				else if (submenu->prompt->type == P_MENU)
+					conf(submenu, NULL);
+				break;
+			case 's':
+				conf_string(submenu);
+				break;
+			}
+			break;
+		case 2:
+			if (sym)
+				show_help(submenu);
+			else {
+				reset_subtitle();
+				show_helptext("README", mconf_readme);
+			}
+			break;
+		case 3:
+			reset_subtitle();
+			conf_save();
+			break;
+		case 4:
+			reset_subtitle();
+			conf_load();
+			break;
+		case 5:
+			if (item_is_tag('t')) {
+				if (sym_set_tristate_value(sym, yes))
+					break;
+				if (sym_set_tristate_value(sym, mod))
+					show_textbox(NULL, setmod_text, 6, 74);
+			}
+			break;
+		case 6:
+			if (item_is_tag('t'))
+				sym_set_tristate_value(sym, no);
+			break;
+		case 7:
+			if (item_is_tag('t'))
+				sym_set_tristate_value(sym, mod);
+			break;
+		case 8:
+			if (item_is_tag('t'))
+				sym_toggle_tristate_value(sym);
+			else if (item_is_tag('m'))
+				conf(submenu, NULL);
+			break;
+		case 9:
+			search_conf();
+			break;
+		case 10:
+			show_all_options = !show_all_options;
+			break;
+		}
+	}
+
+	list_del(trail.prev);
+}
+
+static int show_textbox_ext(const char *title, char *text, int r, int c, int
+			    *keys, int *vscroll, int *hscroll, update_text_fn
+			    update_text, void *data)
+{
+	dialog_clear();
+	return dialog_textbox(title, text, r, c, keys, vscroll, hscroll,
+			      update_text, data);
+}
+
+static void show_textbox(const char *title, const char *text, int r, int c)
+{
+	show_textbox_ext(title, (char *) text, r, c, (int []) {0}, NULL, NULL,
+			 NULL, NULL);
+}
+
+static void show_helptext(const char *title, const char *text)
+{
+	show_textbox(title, text, 0, 0);
+}
+
+static void conf_message_callback(const char *s)
+{
+	if (save_and_exit) {
+		if (!silent)
+			printf("%s", s);
+	} else {
+		show_textbox(NULL, s, 6, 60);
+	}
+}
+
+static void show_help(struct menu *menu)
+{
+	struct gstr help = str_new();
+
+	help.max_width = getmaxx(stdscr) - 10;
+	menu_get_ext_help(menu, &help);
+
+	show_helptext(menu_get_prompt(menu), str_get(&help));
+	str_free(&help);
+}
+
+static void conf_choice(struct menu *menu)
+{
+	const char *prompt = menu_get_prompt(menu);
+	struct menu *child;
+	struct symbol *active;
+
+	active = sym_get_choice_value(menu->sym);
+	while (1) {
+		int res;
+		int selected;
+		item_reset();
+
+		current_menu = menu;
+		for (child = menu->list; child; child = child->next) {
+			if (!menu_is_visible(child))
+				continue;
+			if (child->sym)
+				item_make("%s", menu_get_prompt(child));
+			else {
+				item_make("*** %s ***", menu_get_prompt(child));
+				item_set_tag(':');
+			}
+			item_set_data(child);
+			if (child->sym == active)
+				item_set_selected(1);
+			if (child->sym == sym_get_choice_value(menu->sym))
+				item_set_tag('X');
+		}
+		dialog_clear();
+		res = dialog_checklist(prompt ? prompt : "Main Menu",
+					radiolist_instructions,
+					MENUBOX_HEIGTH_MIN,
+					MENUBOX_WIDTH_MIN,
+					CHECKLIST_HEIGTH_MIN);
+		selected = item_activate_selected();
+		switch (res) {
+		case 0:
+			if (selected) {
+				child = item_data();
+				if (!child->sym)
+					break;
+
+				sym_set_tristate_value(child->sym, yes);
+			}
+			return;
+		case 1:
+			if (selected) {
+				child = item_data();
+				show_help(child);
+				active = child->sym;
+			} else
+				show_help(menu);
+			break;
+		case KEY_ESC:
+			return;
+		case -ERRDISPLAYTOOSMALL:
+			return;
+		}
+	}
+}
+
+static void conf_string(struct menu *menu)
+{
+	const char *prompt = menu_get_prompt(menu);
+
+	while (1) {
+		int res;
+		const char *heading;
+
+		switch (sym_get_type(menu->sym)) {
+		case S_INT:
+			heading = inputbox_instructions_int;
+			break;
+		case S_HEX:
+			heading = inputbox_instructions_hex;
+			break;
+		case S_STRING:
+			heading = inputbox_instructions_string;
+			break;
+		default:
+			heading = "Internal mconf error!";
+		}
+		dialog_clear();
+		res = dialog_inputbox(prompt ? prompt : "Main Menu",
+				      heading, 10, 75,
+				      sym_get_string_value(menu->sym));
+		switch (res) {
+		case 0:
+			if (sym_set_string_value(menu->sym, dialog_input_result))
+				return;
+			show_textbox(NULL, "You have made an invalid entry.", 5, 43);
+			break;
+		case 1:
+			show_help(menu);
+			break;
+		case KEY_ESC:
+			return;
+		}
+	}
+}
+
+static void conf_load(void)
+{
+
+	while (1) {
+		int res;
+		dialog_clear();
+		res = dialog_inputbox(NULL, load_config_text,
+				      11, 55, filename);
+		switch(res) {
+		case 0:
+			if (!dialog_input_result[0])
+				return;
+			if (!conf_read(dialog_input_result)) {
+				set_config_filename(dialog_input_result);
+				conf_set_changed(true);
+				return;
+			}
+			show_textbox(NULL, "File does not exist!", 5, 38);
+			break;
+		case 1:
+			show_helptext("Load Alternate Configuration", load_config_help);
+			break;
+		case KEY_ESC:
+			return;
+		}
+	}
+}
+
+static void conf_save(void)
+{
+	while (1) {
+		int res;
+		dialog_clear();
+		res = dialog_inputbox(NULL, save_config_text,
+				      11, 55, filename);
+		switch(res) {
+		case 0:
+			if (!dialog_input_result[0])
+				return;
+			if (!conf_write(dialog_input_result)) {
+				set_config_filename(dialog_input_result);
+				return;
+			}
+			show_textbox(NULL, "Can't create file!", 5, 60);
+			break;
+		case 1:
+			show_helptext("Save Alternate Configuration", save_config_help);
+			break;
+		case KEY_ESC:
+			return;
+		}
+	}
+}
+
+static int handle_exit(void)
+{
+	int res;
+
+	save_and_exit = 1;
+	reset_subtitle();
+	dialog_clear();
+	if (conf_get_changed())
+		res = dialog_yesno(NULL,
+				   "Do you wish to save your new configuration?\n"
+				     "(Press <ESC><ESC> to continue kernel configuration.)",
+				   6, 60);
+	else
+		res = -1;
+
+	end_dialog(saved_x, saved_y);
+
+	switch (res) {
+	case 0:
+		if (conf_write(filename)) {
+			fprintf(stderr, "\n\n"
+					  "Error while writing of the configuration.\n"
+					  "Your configuration changes were NOT saved."
+					  "\n\n");
+			return 1;
+		}
+		conf_write_autoconf(0);
+		/* fall through */
+	case -1:
+		if (!silent)
+			printf("\n\n"
+				 "*** End of the configuration.\n"
+				 "*** Execute 'make' to start the build or try 'make help'."
+				 "\n\n");
+		res = 0;
+		break;
+	default:
+		if (!silent)
+			fprintf(stderr, "\n\n"
+					  "Your configuration changes were NOT saved."
+					  "\n\n");
+		if (res != KEY_ESC)
+			res = 0;
+	}
+
+	return res;
+}
+
+static void sig_handler(int signo)
+{
+	exit(handle_exit());
+}
+
+int main(int ac, char **av)
+{
+	char *mode;
+	int res;
+
+	signal(SIGINT, sig_handler);
+
+	if (ac > 1 && strcmp(av[1], "-s") == 0) {
+		silent = 1;
+		/* Silence conf_read() until the real callback is set up */
+		conf_set_message_callback(NULL);
+		av++;
+	}
+	conf_parse(av[1]);
+	conf_read(NULL);
+
+	mode = getenv("MENUCONFIG_MODE");
+	if (mode) {
+		if (!strcasecmp(mode, "single_menu"))
+			single_menu_mode = 1;
+	}
+
+	if (init_dialog(NULL)) {
+		fprintf(stderr, "Your display is too small to run Menuconfig!\n");
+		fprintf(stderr, "It must be at least 19 lines by 80 columns.\n");
+		return 1;
+	}
+
+	set_config_filename(conf_get_configname());
+	conf_set_message_callback(conf_message_callback);
+	do {
+		conf(&rootmenu, NULL);
+		res = handle_exit();
+	} while (res == KEY_ESC);
+
+	return res;
+}
diff --git a/backport/kconf/menu.c b/backport/kconf/menu.c
new file mode 100644
index 000000000000..3d6f7cba8846
--- /dev/null
+++ b/backport/kconf/menu.c
@@ -0,0 +1,881 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2002 Roman Zippel <zippel@linux-m68k.org>
+ */
+
+#include <ctype.h>
+#include <stdarg.h>
+#include <stdlib.h>
+#include <string.h>
+
+#include "lkc.h"
+#include "internal.h"
+
+static const char nohelp_text[] = "There is no help available for this option.";
+
+struct menu rootmenu;
+static struct menu **last_entry_ptr;
+
+struct file *file_list;
+struct file *current_file;
+
+void menu_warn(struct menu *menu, const char *fmt, ...)
+{
+	va_list ap;
+	va_start(ap, fmt);
+	fprintf(stderr, "%s:%d:warning: ", menu->file->name, menu->lineno);
+	vfprintf(stderr, fmt, ap);
+	fprintf(stderr, "\n");
+	va_end(ap);
+}
+
+static void prop_warn(struct property *prop, const char *fmt, ...)
+{
+	va_list ap;
+	va_start(ap, fmt);
+	fprintf(stderr, "%s:%d:warning: ", prop->file->name, prop->lineno);
+	vfprintf(stderr, fmt, ap);
+	fprintf(stderr, "\n");
+	va_end(ap);
+}
+
+void _menu_init(void)
+{
+	current_entry = current_menu = &rootmenu;
+	last_entry_ptr = &rootmenu.list;
+}
+
+void menu_add_entry(struct symbol *sym)
+{
+	struct menu *menu;
+
+	menu = xmalloc(sizeof(*menu));
+	memset(menu, 0, sizeof(*menu));
+	menu->sym = sym;
+	menu->parent = current_menu;
+	menu->file = current_file;
+	menu->lineno = zconf_lineno();
+
+	*last_entry_ptr = menu;
+	last_entry_ptr = &menu->next;
+	current_entry = menu;
+	if (sym)
+		menu_add_symbol(P_SYMBOL, sym, NULL);
+}
+
+struct menu *menu_add_menu(void)
+{
+	last_entry_ptr = &current_entry->list;
+	current_menu = current_entry;
+	return current_menu;
+}
+
+void menu_end_menu(void)
+{
+	last_entry_ptr = &current_menu->next;
+	current_menu = current_menu->parent;
+}
+
+/*
+ * Rewrites 'm' to 'm' && MODULES, so that it evaluates to 'n' when running
+ * without modules
+ */
+static struct expr *rewrite_m(struct expr *e)
+{
+	if (!e)
+		return e;
+
+	switch (e->type) {
+	case E_NOT:
+		e->left.expr = rewrite_m(e->left.expr);
+		break;
+	case E_OR:
+	case E_AND:
+		e->left.expr = rewrite_m(e->left.expr);
+		e->right.expr = rewrite_m(e->right.expr);
+		break;
+	case E_SYMBOL:
+		/* change 'm' into 'm' && MODULES */
+		if (e->left.sym == &symbol_mod)
+			return expr_alloc_and(e, expr_alloc_symbol(modules_sym));
+		break;
+	default:
+		break;
+	}
+	return e;
+}
+
+void menu_add_dep(struct expr *dep)
+{
+	current_entry->dep = expr_alloc_and(current_entry->dep, dep);
+}
+
+void menu_set_type(int type)
+{
+	struct symbol *sym = current_entry->sym;
+
+	if (sym->type == type)
+		return;
+	if (sym->type == S_UNKNOWN) {
+		sym->type = type;
+		return;
+	}
+	menu_warn(current_entry,
+		"ignoring type redefinition of '%s' from '%s' to '%s'",
+		sym->name ? sym->name : "<choice>",
+		sym_type_name(sym->type), sym_type_name(type));
+}
+
+static struct property *menu_add_prop(enum prop_type type, struct expr *expr,
+				      struct expr *dep)
+{
+	struct property *prop;
+
+	prop = xmalloc(sizeof(*prop));
+	memset(prop, 0, sizeof(*prop));
+	prop->type = type;
+	prop->file = current_file;
+	prop->lineno = zconf_lineno();
+	prop->menu = current_entry;
+	prop->expr = expr;
+	prop->visible.expr = dep;
+
+	/* append property to the prop list of symbol */
+	if (current_entry->sym) {
+		struct property **propp;
+
+		for (propp = &current_entry->sym->prop;
+		     *propp;
+		     propp = &(*propp)->next)
+			;
+		*propp = prop;
+	}
+
+	return prop;
+}
+
+struct property *menu_add_prompt(enum prop_type type, char *prompt,
+				 struct expr *dep)
+{
+	struct property *prop = menu_add_prop(type, NULL, dep);
+
+	if (isspace(*prompt)) {
+		prop_warn(prop, "leading whitespace ignored");
+		while (isspace(*prompt))
+			prompt++;
+	}
+	if (current_entry->prompt)
+		prop_warn(prop, "prompt redefined");
+
+	/* Apply all upper menus' visibilities to actual prompts. */
+	if (type == P_PROMPT) {
+		struct menu *menu = current_entry;
+
+		while ((menu = menu->parent) != NULL) {
+			struct expr *dup_expr;
+
+			if (!menu->visibility)
+				continue;
+			/*
+			 * Do not add a reference to the menu's visibility
+			 * expression but use a copy of it. Otherwise the
+			 * expression reduction functions will modify
+			 * expressions that have multiple references which
+			 * can cause unwanted side effects.
+			 */
+			dup_expr = expr_copy(menu->visibility);
+
+			prop->visible.expr = expr_alloc_and(prop->visible.expr,
+							    dup_expr);
+		}
+	}
+
+	current_entry->prompt = prop;
+	prop->text = prompt;
+
+	return prop;
+}
+
+void menu_add_visibility(struct expr *expr)
+{
+	current_entry->visibility = expr_alloc_and(current_entry->visibility,
+	    expr);
+}
+
+void menu_add_expr(enum prop_type type, struct expr *expr, struct expr *dep)
+{
+	menu_add_prop(type, expr, dep);
+}
+
+void menu_add_symbol(enum prop_type type, struct symbol *sym, struct expr *dep)
+{
+	menu_add_prop(type, expr_alloc_symbol(sym), dep);
+}
+
+static int menu_validate_number(struct symbol *sym, struct symbol *sym2)
+{
+	return sym2->type == S_INT || sym2->type == S_HEX ||
+	       (sym2->type == S_UNKNOWN && sym_string_valid(sym, sym2->name));
+}
+
+static void sym_check_prop(struct symbol *sym)
+{
+	struct property *prop;
+	struct symbol *sym2;
+	char *use;
+
+	for (prop = sym->prop; prop; prop = prop->next) {
+		switch (prop->type) {
+		case P_DEFAULT:
+			if ((sym->type == S_STRING || sym->type == S_INT || sym->type == S_HEX) &&
+			    prop->expr->type != E_SYMBOL)
+				prop_warn(prop,
+				    "default for config symbol '%s'"
+				    " must be a single symbol", sym->name);
+			if (prop->expr->type != E_SYMBOL)
+				break;
+			sym2 = prop_get_symbol(prop);
+			if (sym->type == S_HEX || sym->type == S_INT) {
+				if (!menu_validate_number(sym, sym2))
+					prop_warn(prop,
+					    "'%s': number is invalid",
+					    sym->name);
+			}
+			if (sym_is_choice(sym)) {
+				struct property *choice_prop =
+					sym_get_choice_prop(sym2);
+
+				if (!choice_prop ||
+				    prop_get_symbol(choice_prop) != sym)
+					prop_warn(prop,
+						  "choice default symbol '%s' is not contained in the choice",
+						  sym2->name);
+			}
+			break;
+		case P_SELECT:
+		case P_IMPLY:
+			use = prop->type == P_SELECT ? "select" : "imply";
+			sym2 = prop_get_symbol(prop);
+			if (sym->type != S_BOOLEAN && sym->type != S_TRISTATE)
+				prop_warn(prop,
+				    "config symbol '%s' uses %s, but is "
+				    "not bool or tristate", sym->name, use);
+			else if (sym2->type != S_UNKNOWN &&
+				 sym2->type != S_BOOLEAN &&
+				 sym2->type != S_TRISTATE)
+				prop_warn(prop,
+				    "'%s' has wrong type. '%s' only "
+				    "accept arguments of bool and "
+				    "tristate type", sym2->name, use);
+			break;
+		case P_RANGE:
+			if (sym->type != S_INT && sym->type != S_HEX)
+				prop_warn(prop, "range is only allowed "
+						"for int or hex symbols");
+			if (!menu_validate_number(sym, prop->expr->left.sym) ||
+			    !menu_validate_number(sym, prop->expr->right.sym))
+				prop_warn(prop, "range is invalid");
+			break;
+		default:
+			;
+		}
+	}
+}
+
+void menu_finalize(struct menu *parent)
+{
+	struct menu *menu, *last_menu;
+	struct symbol *sym;
+	struct property *prop;
+	struct expr *parentdep, *basedep, *dep, *dep2, **ep;
+
+	sym = parent->sym;
+	if (parent->list) {
+		/*
+		 * This menu node has children. We (recursively) process them
+		 * and propagate parent dependencies before moving on.
+		 */
+
+		if (sym && sym_is_choice(sym)) {
+			if (sym->type == S_UNKNOWN) {
+				/* find the first choice value to find out choice type */
+				current_entry = parent;
+				for (menu = parent->list; menu; menu = menu->next) {
+					if (menu->sym && menu->sym->type != S_UNKNOWN) {
+						menu_set_type(menu->sym->type);
+						break;
+					}
+				}
+			}
+			/* set the type of the remaining choice values */
+			for (menu = parent->list; menu; menu = menu->next) {
+				current_entry = menu;
+				if (menu->sym && menu->sym->type == S_UNKNOWN)
+					menu_set_type(sym->type);
+			}
+
+			/*
+			 * Use the choice itself as the parent dependency of
+			 * the contained items. This turns the mode of the
+			 * choice into an upper bound on the visibility of the
+			 * choice value symbols.
+			 */
+			parentdep = expr_alloc_symbol(sym);
+		} else {
+			/* Menu node for 'menu', 'if' */
+			parentdep = parent->dep;
+		}
+
+		/* For each child menu node... */
+		for (menu = parent->list; menu; menu = menu->next) {
+			/*
+			 * Propagate parent dependencies to the child menu
+			 * node, also rewriting and simplifying expressions
+			 */
+			basedep = rewrite_m(menu->dep);
+			basedep = expr_transform(basedep);
+			basedep = expr_alloc_and(expr_copy(parentdep), basedep);
+			basedep = expr_eliminate_dups(basedep);
+			menu->dep = basedep;
+
+			if (menu->sym)
+				/*
+				 * Note: For symbols, all prompts are included
+				 * too in the symbol's own property list
+				 */
+				prop = menu->sym->prop;
+			else
+				/*
+				 * For non-symbol menu nodes, we just need to
+				 * handle the prompt
+				 */
+				prop = menu->prompt;
+
+			/* For each property... */
+			for (; prop; prop = prop->next) {
+				if (prop->menu != menu)
+					/*
+					 * Two possibilities:
+					 *
+					 * 1. The property lacks dependencies
+					 *    and so isn't location-specific,
+					 *    e.g. an 'option'
+					 *
+					 * 2. The property belongs to a symbol
+					 *    defined in multiple locations and
+					 *    is from some other location. It
+					 *    will be handled there in that
+					 *    case.
+					 *
+					 * Skip the property.
+					 */
+					continue;
+
+				/*
+				 * Propagate parent dependencies to the
+				 * property's condition, rewriting and
+				 * simplifying expressions at the same time
+				 */
+				dep = rewrite_m(prop->visible.expr);
+				dep = expr_transform(dep);
+				dep = expr_alloc_and(expr_copy(basedep), dep);
+				dep = expr_eliminate_dups(dep);
+				if (menu->sym && menu->sym->type != S_TRISTATE)
+					dep = expr_trans_bool(dep);
+				prop->visible.expr = dep;
+
+				/*
+				 * Handle selects and implies, which modify the
+				 * dependencies of the selected/implied symbol
+				 */
+				if (prop->type == P_SELECT) {
+					struct symbol *es = prop_get_symbol(prop);
+					es->rev_dep.expr = expr_alloc_or(es->rev_dep.expr,
+							expr_alloc_and(expr_alloc_symbol(menu->sym), expr_copy(dep)));
+				} else if (prop->type == P_IMPLY) {
+					struct symbol *es = prop_get_symbol(prop);
+					es->implied.expr = expr_alloc_or(es->implied.expr,
+							expr_alloc_and(expr_alloc_symbol(menu->sym), expr_copy(dep)));
+				}
+			}
+		}
+
+		if (sym && sym_is_choice(sym))
+			expr_free(parentdep);
+
+		/*
+		 * Recursively process children in the same fashion before
+		 * moving on
+		 */
+		for (menu = parent->list; menu; menu = menu->next)
+			menu_finalize(menu);
+	} else if (sym) {
+		/*
+		 * Automatic submenu creation. If sym is a symbol and A, B, C,
+		 * ... are consecutive items (symbols, menus, ifs, etc.) that
+		 * all depend on sym, then the following menu structure is
+		 * created:
+		 *
+		 *	sym
+		 *	 +-A
+		 *	 +-B
+		 *	 +-C
+		 *	 ...
+		 *
+		 * This also works recursively, giving the following structure
+		 * if A is a symbol and B depends on A:
+		 *
+		 *	sym
+		 *	 +-A
+		 *	 | +-B
+		 *	 +-C
+		 *	 ...
+		 */
+
+		basedep = parent->prompt ? parent->prompt->visible.expr : NULL;
+		basedep = expr_trans_compare(basedep, E_UNEQUAL, &symbol_no);
+		basedep = expr_eliminate_dups(expr_transform(basedep));
+
+		/* Examine consecutive elements after sym */
+		last_menu = NULL;
+		for (menu = parent->next; menu; menu = menu->next) {
+			dep = menu->prompt ? menu->prompt->visible.expr : menu->dep;
+			if (!expr_contains_symbol(dep, sym))
+				/* No dependency, quit */
+				break;
+			if (expr_depends_symbol(dep, sym))
+				/* Absolute dependency, put in submenu */
+				goto next;
+
+			/*
+			 * Also consider it a dependency on sym if our
+			 * dependencies contain sym and are a "superset" of
+			 * sym's dependencies, e.g. '(sym || Q) && R' when sym
+			 * depends on R.
+			 *
+			 * Note that 'R' might be from an enclosing menu or if,
+			 * making this a more common case than it might seem.
+			 */
+			dep = expr_trans_compare(dep, E_UNEQUAL, &symbol_no);
+			dep = expr_eliminate_dups(expr_transform(dep));
+			dep2 = expr_copy(basedep);
+			expr_eliminate_eq(&dep, &dep2);
+			expr_free(dep);
+			if (!expr_is_yes(dep2)) {
+				/* Not superset, quit */
+				expr_free(dep2);
+				break;
+			}
+			/* Superset, put in submenu */
+			expr_free(dep2);
+		next:
+			menu_finalize(menu);
+			menu->parent = parent;
+			last_menu = menu;
+		}
+		expr_free(basedep);
+		if (last_menu) {
+			parent->list = parent->next;
+			parent->next = last_menu->next;
+			last_menu->next = NULL;
+		}
+
+		sym->dir_dep.expr = expr_alloc_or(sym->dir_dep.expr, parent->dep);
+	}
+	for (menu = parent->list; menu; menu = menu->next) {
+		if (sym && sym_is_choice(sym) &&
+		    menu->sym && !sym_is_choice_value(menu->sym)) {
+			current_entry = menu;
+			menu->sym->flags |= SYMBOL_CHOICEVAL;
+			if (!menu->prompt)
+				menu_warn(menu, "choice value must have a prompt");
+			for (prop = menu->sym->prop; prop; prop = prop->next) {
+				if (prop->type == P_DEFAULT)
+					prop_warn(prop, "defaults for choice "
+						  "values not supported");
+				if (prop->menu == menu)
+					continue;
+				if (prop->type == P_PROMPT &&
+				    prop->menu->parent->sym != sym)
+					prop_warn(prop, "choice value used outside its choice group");
+			}
+			/* Non-tristate choice values of tristate choices must
+			 * depend on the choice being set to Y. The choice
+			 * values' dependencies were propagated to their
+			 * properties above, so the change here must be re-
+			 * propagated.
+			 */
+			if (sym->type == S_TRISTATE && menu->sym->type != S_TRISTATE) {
+				basedep = expr_alloc_comp(E_EQUAL, sym, &symbol_yes);
+				menu->dep = expr_alloc_and(basedep, menu->dep);
+				for (prop = menu->sym->prop; prop; prop = prop->next) {
+					if (prop->menu != menu)
+						continue;
+					prop->visible.expr = expr_alloc_and(expr_copy(basedep),
+									    prop->visible.expr);
+				}
+			}
+			menu_add_symbol(P_CHOICE, sym, NULL);
+			prop = sym_get_choice_prop(sym);
+			for (ep = &prop->expr; *ep; ep = &(*ep)->left.expr)
+				;
+			*ep = expr_alloc_one(E_LIST, NULL);
+			(*ep)->right.sym = menu->sym;
+		}
+
+		/*
+		 * This code serves two purposes:
+		 *
+		 * (1) Flattening 'if' blocks, which do not specify a submenu
+		 *     and only add dependencies.
+		 *
+		 *     (Automatic submenu creation might still create a submenu
+		 *     from an 'if' before this code runs.)
+		 *
+		 * (2) "Undoing" any automatic submenus created earlier below
+		 *     promptless symbols.
+		 *
+		 * Before:
+		 *
+		 *	A
+		 *	if ... (or promptless symbol)
+		 *	 +-B
+		 *	 +-C
+		 *	D
+		 *
+		 * After:
+		 *
+		 *	A
+		 *	if ... (or promptless symbol)
+		 *	B
+		 *	C
+		 *	D
+		 */
+		if (menu->list && (!menu->prompt || !menu->prompt->text)) {
+			for (last_menu = menu->list; ; last_menu = last_menu->next) {
+				last_menu->parent = parent;
+				if (!last_menu->next)
+					break;
+			}
+			last_menu->next = menu->next;
+			menu->next = menu->list;
+			menu->list = NULL;
+		}
+	}
+
+	if (sym && !(sym->flags & SYMBOL_WARNED)) {
+		if (sym->type == S_UNKNOWN)
+			menu_warn(parent, "config symbol defined without type");
+
+		if (sym_is_choice(sym) && !parent->prompt)
+			menu_warn(parent, "choice must have a prompt");
+
+		/* Check properties connected to this symbol */
+		sym_check_prop(sym);
+		sym->flags |= SYMBOL_WARNED;
+	}
+
+	/*
+	 * For non-optional choices, add a reverse dependency (corresponding to
+	 * a select) of '<visibility> && m'. This prevents the user from
+	 * setting the choice mode to 'n' when the choice is visible.
+	 *
+	 * This would also work for non-choice symbols, but only non-optional
+	 * choices clear SYMBOL_OPTIONAL as of writing. Choices are implemented
+	 * as a type of symbol.
+	 */
+	if (sym && !sym_is_optional(sym) && parent->prompt) {
+		sym->rev_dep.expr = expr_alloc_or(sym->rev_dep.expr,
+				expr_alloc_and(parent->prompt->visible.expr,
+					expr_alloc_symbol(&symbol_mod)));
+	}
+}
+
+bool menu_has_prompt(struct menu *menu)
+{
+	if (!menu->prompt)
+		return false;
+	return true;
+}
+
+/*
+ * Determine if a menu is empty.
+ * A menu is considered empty if it contains no or only
+ * invisible entries.
+ */
+bool menu_is_empty(struct menu *menu)
+{
+	struct menu *child;
+
+	for (child = menu->list; child; child = child->next) {
+		if (menu_is_visible(child))
+			return(false);
+	}
+	return(true);
+}
+
+bool menu_is_visible(struct menu *menu)
+{
+	struct menu *child;
+	struct symbol *sym;
+	tristate visible;
+
+	if (!menu->prompt)
+		return false;
+
+	if (menu->visibility) {
+		if (expr_calc_value(menu->visibility) == no)
+			return false;
+	}
+
+	sym = menu->sym;
+	if (sym) {
+		sym_calc_value(sym);
+		visible = menu->prompt->visible.tri;
+	} else
+		visible = menu->prompt->visible.tri = expr_calc_value(menu->prompt->visible.expr);
+
+	if (visible != no)
+		return true;
+
+	if (!sym || sym_get_tristate_value(menu->sym) == no)
+		return false;
+
+	for (child = menu->list; child; child = child->next) {
+		if (menu_is_visible(child)) {
+			if (sym)
+				sym->flags |= SYMBOL_DEF_USER;
+			return true;
+		}
+	}
+
+	return false;
+}
+
+const char *menu_get_prompt(struct menu *menu)
+{
+	if (menu->prompt)
+		return menu->prompt->text;
+	else if (menu->sym)
+		return menu->sym->name;
+	return NULL;
+}
+
+struct menu *menu_get_root_menu(struct menu *menu)
+{
+	return &rootmenu;
+}
+
+struct menu *menu_get_parent_menu(struct menu *menu)
+{
+	enum prop_type type;
+
+	for (; menu != &rootmenu; menu = menu->parent) {
+		type = menu->prompt ? menu->prompt->type : 0;
+		if (type == P_MENU)
+			break;
+	}
+	return menu;
+}
+
+bool menu_has_help(struct menu *menu)
+{
+	return menu->help != NULL;
+}
+
+const char *menu_get_help(struct menu *menu)
+{
+	if (menu->help)
+		return menu->help;
+	else
+		return "";
+}
+
+static void get_def_str(struct gstr *r, struct menu *menu)
+{
+	str_printf(r, "Defined at %s:%d\n",
+		   menu->file->name, menu->lineno);
+}
+
+static void get_dep_str(struct gstr *r, struct expr *expr, const char *prefix)
+{
+	if (!expr_is_yes(expr)) {
+		str_append(r, prefix);
+		expr_gstr_print(expr, r);
+		str_append(r, "\n");
+	}
+}
+
+static void get_prompt_str(struct gstr *r, struct property *prop,
+			   struct list_head *head)
+{
+	int i, j;
+	struct menu *submenu[8], *menu, *location = NULL;
+	struct jump_key *jump = NULL;
+
+	str_printf(r, "  Prompt: %s\n", prop->text);
+
+	get_dep_str(r, prop->menu->dep, "  Depends on: ");
+	/*
+	 * Most prompts in Linux have visibility that exactly matches their
+	 * dependencies. For these, we print only the dependencies to improve
+	 * readability. However, prompts with inline "if" expressions and
+	 * prompts with a parent that has a "visible if" expression have
+	 * differing dependencies and visibility. In these rare cases, we
+	 * print both.
+	 */
+	if (!expr_eq(prop->menu->dep, prop->visible.expr))
+		get_dep_str(r, prop->visible.expr, "  Visible if: ");
+
+	menu = prop->menu->parent;
+	for (i = 0; menu && i < 8; menu = menu->parent) {
+		bool accessible = menu_is_visible(menu);
+
+		submenu[i++] = menu;
+		if (location == NULL && accessible)
+			location = menu;
+	}
+	if (head && location) {
+		jump = xmalloc(sizeof(struct jump_key));
+
+		if (menu_is_visible(prop->menu)) {
+			/*
+			 * There is not enough room to put the hint at the
+			 * beginning of the "Prompt" line. Put the hint on the
+			 * last "Location" line even when it would belong on
+			 * the former.
+			 */
+			jump->target = prop->menu;
+		} else
+			jump->target = location;
+
+		if (list_empty(head))
+			jump->index = 0;
+		else
+			jump->index = list_entry(head->prev, struct jump_key,
+						 entries)->index + 1;
+
+		list_add_tail(&jump->entries, head);
+	}
+
+	str_printf(r, "  Location:\n");
+	for (j = 4; --i >= 0; j += 2) {
+		menu = submenu[i];
+		if (jump && menu == location)
+			jump->offset = strlen(r->s);
+
+		if (menu == &rootmenu)
+			/* The real rootmenu prompt is ugly */
+			str_printf(r, "%*cMain menu", j, ' ');
+		else
+			str_printf(r, "%*c-> %s", j, ' ', menu_get_prompt(menu));
+
+		if (menu->sym) {
+			str_printf(r, " (%s [=%s])", menu->sym->name ?
+				menu->sym->name : "<choice>",
+				sym_get_string_value(menu->sym));
+		}
+		str_append(r, "\n");
+	}
+}
+
+static void get_symbol_props_str(struct gstr *r, struct symbol *sym,
+				 enum prop_type tok, const char *prefix)
+{
+	bool hit = false;
+	struct property *prop;
+
+	for_all_properties(sym, prop, tok) {
+		if (!hit) {
+			str_append(r, prefix);
+			hit = true;
+		} else
+			str_printf(r, " && ");
+		expr_gstr_print(prop->expr, r);
+	}
+	if (hit)
+		str_append(r, "\n");
+}
+
+/*
+ * head is optional and may be NULL
+ */
+static void get_symbol_str(struct gstr *r, struct symbol *sym,
+		    struct list_head *head)
+{
+	struct property *prop;
+
+	if (sym && sym->name) {
+		str_printf(r, "Symbol: %s [=%s]\n", sym->name,
+			   sym_get_string_value(sym));
+		str_printf(r, "Type  : %s\n", sym_type_name(sym->type));
+		if (sym->type == S_INT || sym->type == S_HEX) {
+			prop = sym_get_range_prop(sym);
+			if (prop) {
+				str_printf(r, "Range : ");
+				expr_gstr_print(prop->expr, r);
+				str_append(r, "\n");
+			}
+		}
+	}
+
+	/* Print the definitions with prompts before the ones without */
+	for_all_properties(sym, prop, P_SYMBOL) {
+		if (prop->menu->prompt) {
+			get_def_str(r, prop->menu);
+			get_prompt_str(r, prop->menu->prompt, head);
+		}
+	}
+
+	for_all_properties(sym, prop, P_SYMBOL) {
+		if (!prop->menu->prompt) {
+			get_def_str(r, prop->menu);
+			get_dep_str(r, prop->menu->dep, "  Depends on: ");
+		}
+	}
+
+	get_symbol_props_str(r, sym, P_SELECT, "Selects: ");
+	if (sym->rev_dep.expr) {
+		expr_gstr_print_revdep(sym->rev_dep.expr, r, yes, "Selected by [y]:\n");
+		expr_gstr_print_revdep(sym->rev_dep.expr, r, mod, "Selected by [m]:\n");
+		expr_gstr_print_revdep(sym->rev_dep.expr, r, no, "Selected by [n]:\n");
+	}
+
+	get_symbol_props_str(r, sym, P_IMPLY, "Implies: ");
+	if (sym->implied.expr) {
+		expr_gstr_print_revdep(sym->implied.expr, r, yes, "Implied by [y]:\n");
+		expr_gstr_print_revdep(sym->implied.expr, r, mod, "Implied by [m]:\n");
+		expr_gstr_print_revdep(sym->implied.expr, r, no, "Implied by [n]:\n");
+	}
+
+	str_append(r, "\n\n");
+}
+
+struct gstr get_relations_str(struct symbol **sym_arr, struct list_head *head)
+{
+	struct symbol *sym;
+	struct gstr res = str_new();
+	int i;
+
+	for (i = 0; sym_arr && (sym = sym_arr[i]); i++)
+		get_symbol_str(&res, sym, head);
+	if (!i)
+		str_append(&res, "No matches found.\n");
+	return res;
+}
+
+
+void menu_get_ext_help(struct menu *menu, struct gstr *help)
+{
+	struct symbol *sym = menu->sym;
+	const char *help_text = nohelp_text;
+
+	if (menu_has_help(menu)) {
+		if (sym->name)
+			str_printf(help, "%s%s:\n\n", CONFIG_, sym->name);
+		help_text = menu_get_help(menu);
+	}
+	str_printf(help, "%s\n", help_text);
+	if (sym)
+		get_symbol_str(help, sym, NULL);
+}
diff --git a/backport/kconf/nconf-cfg.sh b/backport/kconf/nconf-cfg.sh
new file mode 100755
index 000000000000..c212255070c0
--- /dev/null
+++ b/backport/kconf/nconf-cfg.sh
@@ -0,0 +1,50 @@
+#!/bin/sh
+# SPDX-License-Identifier: GPL-2.0
+
+PKG="ncursesw menuw panelw"
+PKG2="ncurses menu panel"
+
+if [ -n "$(command -v pkg-config)" ]; then
+	if pkg-config --exists $PKG; then
+		echo cflags=\"$(pkg-config --cflags $PKG)\"
+		echo libs=\"$(pkg-config --libs $PKG)\"
+		exit 0
+	fi
+
+	if pkg-config --exists $PKG2; then
+		echo cflags=\"$(pkg-config --cflags $PKG2)\"
+		echo libs=\"$(pkg-config --libs $PKG2)\"
+		exit 0
+	fi
+fi
+
+# Check the default paths in case pkg-config is not installed.
+# (Even if it is installed, some distributions such as openSUSE cannot
+# find ncurses by pkg-config.)
+if [ -f /usr/include/ncursesw/ncurses.h ]; then
+	echo cflags=\"-D_GNU_SOURCE -I/usr/include/ncursesw\"
+	echo libs=\"-lncursesw -lmenuw -lpanelw\"
+	exit 0
+fi
+
+if [ -f /usr/include/ncurses/ncurses.h ]; then
+	echo cflags=\"-D_GNU_SOURCE -I/usr/include/ncurses\"
+	echo libs=\"-lncurses -lmenu -lpanel\"
+	exit 0
+fi
+
+if [ -f /usr/include/ncurses.h ]; then
+	echo cflags=\"-D_GNU_SOURCE\"
+	echo libs=\"-lncurses -lmenu -lpanel\"
+	exit 0
+fi
+
+echo >&2 "*"
+echo >&2 "* Unable to find the ncurses package."
+echo >&2 "* Install ncurses (ncurses-devel or libncurses-dev"
+echo >&2 "* depending on your distribution)."
+echo >&2 "*"
+echo >&2 "* You may also need to install pkg-config to find the"
+echo >&2 "* ncurses installed in a non-default location."
+echo >&2 "*"
+exit 1
diff --git a/backport/kconf/nconf.c b/backport/kconf/nconf.c
new file mode 100644
index 000000000000..7b371bd7fb36
--- /dev/null
+++ b/backport/kconf/nconf.c
@@ -0,0 +1,1549 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2008 Nir Tzachar <nir.tzachar@gmail.com>
+ *
+ * Derived from menuconfig.
+ */
+#ifndef _GNU_SOURCE
+#define _GNU_SOURCE
+#endif
+#include <string.h>
+#include <strings.h>
+#include <stdlib.h>
+
+#include "lkc.h"
+#include "nconf.h"
+#include <ctype.h>
+
+static const char nconf_global_help[] =
+"Help windows\n"
+"------------\n"
+"o  Global help:  Unless in a data entry window, pressing <F1> will give \n"
+"   you the global help window, which you are just reading.\n"
+"\n"
+"o  A short version of the global help is available by pressing <F3>.\n"
+"\n"
+"o  Local help:  To get help related to the current menu entry, use any\n"
+"   of <?> <h>, or if in a data entry window then press <F1>.\n"
+"\n"
+"\n"
+"Menu entries\n"
+"------------\n"
+"This interface lets you select features and parameters for the kernel\n"
+"build.  Kernel features can either be built-in, modularized, or removed.\n"
+"Parameters must be entered as text or decimal or hexadecimal numbers.\n"
+"\n"
+"Menu entries beginning with following braces represent features that\n"
+"  [ ]  can be built in or removed\n"
+"  < >  can be built in, modularized or removed\n"
+"  { }  can be built in or modularized, are selected by another feature\n"
+"  - -  are selected by another feature\n"
+"  XXX  cannot be selected.  Symbol Info <F2> tells you why.\n"
+"*, M or whitespace inside braces means to build in, build as a module\n"
+"or to exclude the feature respectively.\n"
+"\n"
+"To change any of these features, highlight it with the movement keys\n"
+"listed below and press <y> to build it in, <m> to make it a module or\n"
+"<n> to remove it.  You may press the <Space> key to cycle through the\n"
+"available options.\n"
+"\n"
+"A trailing \"--->\" designates a submenu, a trailing \"----\" an\n"
+"empty submenu.\n"
+"\n"
+"Menu navigation keys\n"
+"----------------------------------------------------------------------\n"
+"Linewise up                 <Up>\n"
+"Linewise down               <Down>\n"
+"Pagewise up                 <Page Up>\n"
+"Pagewise down               <Page Down>\n"
+"First entry                 <Home>\n"
+"Last entry                  <End>\n"
+"Enter a submenu             <Right>  <Enter>\n"
+"Go back to parent menu      <Left>   <Esc>  <F5>\n"
+"Close a help window         <Enter>  <Esc>  <F5>\n"
+"Close entry window, apply   <Enter>\n"
+"Close entry window, forget  <Esc>  <F5>\n"
+"Start incremental, case-insensitive search for STRING in menu entries,\n"
+"    no regex support, STRING is displayed in upper left corner\n"
+"                            </>STRING\n"
+"    Remove last character   <Backspace>\n"
+"    Jump to next hit        <Down>\n"
+"    Jump to previous hit    <Up>\n"
+"Exit menu search mode       </>  <Esc>\n"
+"Search for configuration variables with or without leading CONFIG_\n"
+"                            <F8>RegExpr<Enter>\n"
+"Verbose search help         <F8><F1>\n"
+"----------------------------------------------------------------------\n"
+"\n"
+"Unless in a data entry window, key <1> may be used instead of <F1>,\n"
+"<2> instead of <F2>, etc.\n"
+"\n"
+"\n"
+"Radiolist (Choice list)\n"
+"-----------------------\n"
+"Use the movement keys listed above to select the option you wish to set\n"
+"and press <Space>.\n"
+"\n"
+"\n"
+"Data entry\n"
+"----------\n"
+"Enter the requested information and press <Enter>.  Hexadecimal values\n"
+"may be entered without the \"0x\" prefix.\n"
+"\n"
+"\n"
+"Text Box (Help Window)\n"
+"----------------------\n"
+"Use movement keys as listed in table above.\n"
+"\n"
+"Press any of <Enter> <Esc> <q> <F5> <F9> to exit.\n"
+"\n"
+"\n"
+"Alternate configuration files\n"
+"-----------------------------\n"
+"nconfig supports switching between different configurations.\n"
+"Press <F6> to save your current configuration.  Press <F7> and enter\n"
+"a file name to load a previously saved configuration.\n"
+"\n"
+"\n"
+"Terminal configuration\n"
+"----------------------\n"
+"If you use nconfig in a xterm window, make sure your TERM environment\n"
+"variable specifies a terminal configuration which supports at least\n"
+"16 colors.  Otherwise nconfig will look rather bad.\n"
+"\n"
+"If the \"stty size\" command reports the current terminalsize correctly,\n"
+"nconfig will adapt to sizes larger than the traditional 80x25 \"standard\"\n"
+"and display longer menus properly.\n"
+"\n"
+"\n"
+"Single menu mode\n"
+"----------------\n"
+"If you prefer to have all of the menu entries listed in a single menu,\n"
+"rather than the default multimenu hierarchy, run nconfig with\n"
+"NCONFIG_MODE environment variable set to single_menu.  Example:\n"
+"\n"
+"make NCONFIG_MODE=single_menu nconfig\n"
+"\n"
+"<Enter> will then unfold the appropriate category, or fold it if it\n"
+"is already unfolded.  Folded menu entries will be designated by a\n"
+"leading \"++>\" and unfolded entries by a leading \"-->\".\n"
+"\n"
+"Note that this mode can eventually be a little more CPU expensive than\n"
+"the default mode, especially with a larger number of unfolded submenus.\n"
+"\n",
+menu_no_f_instructions[] =
+"Legend:  [*] built-in  [ ] excluded  <M> module  < > module capable.\n"
+"Submenus are designated by a trailing \"--->\", empty ones by \"----\".\n"
+"\n"
+"Use the following keys to navigate the menus:\n"
+"Move up or down with <Up> and <Down>.\n"
+"Enter a submenu with <Enter> or <Right>.\n"
+"Exit a submenu to its parent menu with <Esc> or <Left>.\n"
+"Pressing <y> includes, <n> excludes, <m> modularizes features.\n"
+"Pressing <Space> cycles through the available options.\n"
+"To search for menu entries press </>.\n"
+"<Esc> always leaves the current window.\n"
+"\n"
+"You do not have function keys support.\n"
+"Press <1> instead of <F1>, <2> instead of <F2>, etc.\n"
+"For verbose global help use key <1>.\n"
+"For help related to the current menu entry press <?> or <h>.\n",
+menu_instructions[] =
+"Legend:  [*] built-in  [ ] excluded  <M> module  < > module capable.\n"
+"Submenus are designated by a trailing \"--->\", empty ones by \"----\".\n"
+"\n"
+"Use the following keys to navigate the menus:\n"
+"Move up or down with <Up> or <Down>.\n"
+"Enter a submenu with <Enter> or <Right>.\n"
+"Exit a submenu to its parent menu with <Esc> or <Left>.\n"
+"Pressing <y> includes, <n> excludes, <m> modularizes features.\n"
+"Pressing <Space> cycles through the available options.\n"
+"To search for menu entries press </>.\n"
+"<Esc> always leaves the current window.\n"
+"\n"
+"Pressing <1> may be used instead of <F1>, <2> instead of <F2>, etc.\n"
+"For verbose global help press <F1>.\n"
+"For help related to the current menu entry press <?> or <h>.\n",
+radiolist_instructions[] =
+"Press <Up>, <Down>, <Home> or <End> to navigate a radiolist, select\n"
+"with <Space>.\n"
+"For help related to the current entry press <?> or <h>.\n"
+"For global help press <F1>.\n",
+inputbox_instructions_int[] =
+"Please enter a decimal value.\n"
+"Fractions will not be accepted.\n"
+"Press <Enter> to apply, <Esc> to cancel.",
+inputbox_instructions_hex[] =
+"Please enter a hexadecimal value.\n"
+"Press <Enter> to apply, <Esc> to cancel.",
+inputbox_instructions_string[] =
+"Please enter a string value.\n"
+"Press <Enter> to apply, <Esc> to cancel.",
+setmod_text[] =
+"This feature depends on another feature which has been configured as a\n"
+"module.  As a result, the current feature will be built as a module too.",
+load_config_text[] =
+"Enter the name of the configuration file you wish to load.\n"
+"Accept the name shown to restore the configuration you last\n"
+"retrieved.  Leave empty to abort.",
+load_config_help[] =
+"For various reasons, one may wish to keep several different\n"
+"configurations available on a single machine.\n"
+"\n"
+"If you have saved a previous configuration in a file other than the\n"
+"default one, entering its name here will allow you to load and modify\n"
+"that configuration.\n"
+"\n"
+"Leave empty to abort.\n",
+save_config_text[] =
+"Enter a filename to which this configuration should be saved\n"
+"as an alternate.  Leave empty to abort.",
+save_config_help[] =
+"For various reasons, one may wish to keep several different\n"
+"configurations available on a single machine.\n"
+"\n"
+"Entering a file name here will allow you to later retrieve, modify\n"
+"and use the current configuration as an alternate to whatever\n"
+"configuration options you have selected at that time.\n"
+"\n"
+"Leave empty to abort.\n",
+search_help[] =
+"Search for symbols (configuration variable names CONFIG_*) and display\n"
+"their relations.  Regular expressions are supported.\n"
+"Example:  Search for \"^FOO\".\n"
+"Result:\n"
+"-----------------------------------------------------------------\n"
+"Symbol: FOO [ = m]\n"
+"Prompt: Foo bus is used to drive the bar HW\n"
+"Defined at drivers/pci/Kconfig:47\n"
+"Depends on: X86_LOCAL_APIC && X86_IO_APIC || IA64\n"
+"Location:\n"
+"  -> Bus options (PCI, PCMCIA, EISA, ISA)\n"
+"    -> PCI support (PCI [ = y])\n"
+"      -> PCI access mode (<choice> [ = y])\n"
+"Selects: LIBCRC32\n"
+"Selected by: BAR\n"
+"-----------------------------------------------------------------\n"
+"o  The line 'Prompt:' shows the text displayed for this symbol in\n"
+"   the menu hierarchy.\n"
+"o  The 'Defined at' line tells at what file / line number the symbol is\n"
+"   defined.\n"
+"o  The 'Depends on:' line lists symbols that need to be defined for\n"
+"   this symbol to be visible and selectable in the menu.\n"
+"o  The 'Location:' lines tell, where in the menu structure this symbol\n"
+"   is located.  A location followed by a [ = y] indicates that this is\n"
+"   a selectable menu item, and the current value is displayed inside\n"
+"   brackets.\n"
+"o  The 'Selects:' line tells, what symbol will be automatically selected\n"
+"   if this symbol is selected (y or m).\n"
+"o  The 'Selected by' line tells what symbol has selected this symbol.\n"
+"\n"
+"Only relevant lines are shown.\n"
+"\n\n"
+"Search examples:\n"
+"USB  => find all symbols containing USB\n"
+"^USB => find all symbols starting with USB\n"
+"USB$ => find all symbols ending with USB\n"
+"\n";
+
+struct mitem {
+	char str[256];
+	char tag;
+	void *usrptr;
+	int is_visible;
+};
+
+#define MAX_MENU_ITEMS 4096
+static int show_all_items;
+static int indent;
+static struct menu *current_menu;
+static int child_count;
+static int single_menu_mode;
+/* the window in which all information appears */
+static WINDOW *main_window;
+/* the largest size of the menu window */
+static int mwin_max_lines;
+static int mwin_max_cols;
+/* the window in which we show option buttons */
+static MENU *curses_menu;
+static ITEM *curses_menu_items[MAX_MENU_ITEMS];
+static struct mitem k_menu_items[MAX_MENU_ITEMS];
+static unsigned int items_num;
+static int global_exit;
+/* the currently selected button */
+static const char *current_instructions = menu_instructions;
+
+static char *dialog_input_result;
+static int dialog_input_result_len;
+
+static void conf(struct menu *menu);
+static void conf_choice(struct menu *menu);
+static void conf_string(struct menu *menu);
+static void conf_load(void);
+static void conf_save(void);
+static void show_help(struct menu *menu);
+static int do_exit(void);
+static void setup_windows(void);
+static void search_conf(void);
+
+typedef void (*function_key_handler_t)(int *key, struct menu *menu);
+static void handle_f1(int *key, struct menu *current_item);
+static void handle_f2(int *key, struct menu *current_item);
+static void handle_f3(int *key, struct menu *current_item);
+static void handle_f4(int *key, struct menu *current_item);
+static void handle_f5(int *key, struct menu *current_item);
+static void handle_f6(int *key, struct menu *current_item);
+static void handle_f7(int *key, struct menu *current_item);
+static void handle_f8(int *key, struct menu *current_item);
+static void handle_f9(int *key, struct menu *current_item);
+
+struct function_keys {
+	const char *key_str;
+	const char *func;
+	function_key key;
+	function_key_handler_t handler;
+};
+
+static const int function_keys_num = 9;
+static struct function_keys function_keys[] = {
+	{
+		.key_str = "F1",
+		.func = "Help",
+		.key = F_HELP,
+		.handler = handle_f1,
+	},
+	{
+		.key_str = "F2",
+		.func = "SymInfo",
+		.key = F_SYMBOL,
+		.handler = handle_f2,
+	},
+	{
+		.key_str = "F3",
+		.func = "Help 2",
+		.key = F_INSTS,
+		.handler = handle_f3,
+	},
+	{
+		.key_str = "F4",
+		.func = "ShowAll",
+		.key = F_CONF,
+		.handler = handle_f4,
+	},
+	{
+		.key_str = "F5",
+		.func = "Back",
+		.key = F_BACK,
+		.handler = handle_f5,
+	},
+	{
+		.key_str = "F6",
+		.func = "Save",
+		.key = F_SAVE,
+		.handler = handle_f6,
+	},
+	{
+		.key_str = "F7",
+		.func = "Load",
+		.key = F_LOAD,
+		.handler = handle_f7,
+	},
+	{
+		.key_str = "F8",
+		.func = "SymSearch",
+		.key = F_SEARCH,
+		.handler = handle_f8,
+	},
+	{
+		.key_str = "F9",
+		.func = "Exit",
+		.key = F_EXIT,
+		.handler = handle_f9,
+	},
+};
+
+static void print_function_line(void)
+{
+	int i;
+	int offset = 1;
+	const int skip = 1;
+	int lines = getmaxy(stdscr);
+
+	for (i = 0; i < function_keys_num; i++) {
+		wattrset(main_window, attr_function_highlight);
+		mvwprintw(main_window, lines-3, offset,
+				"%s",
+				function_keys[i].key_str);
+		wattrset(main_window, attr_function_text);
+		offset += strlen(function_keys[i].key_str);
+		mvwprintw(main_window, lines-3,
+				offset, "%s",
+				function_keys[i].func);
+		offset += strlen(function_keys[i].func) + skip;
+	}
+	wattrset(main_window, attr_normal);
+}
+
+/* help */
+static void handle_f1(int *key, struct menu *current_item)
+{
+	show_scroll_win(main_window,
+			"Global help", nconf_global_help);
+	return;
+}
+
+/* symbole help */
+static void handle_f2(int *key, struct menu *current_item)
+{
+	show_help(current_item);
+	return;
+}
+
+/* instructions */
+static void handle_f3(int *key, struct menu *current_item)
+{
+	show_scroll_win(main_window,
+			"Short help",
+			current_instructions);
+	return;
+}
+
+/* config */
+static void handle_f4(int *key, struct menu *current_item)
+{
+	int res = btn_dialog(main_window,
+			"Show all symbols?",
+			2,
+			"   <Show All>   ",
+			"<Don't show all>");
+	if (res == 0)
+		show_all_items = 1;
+	else if (res == 1)
+		show_all_items = 0;
+
+	return;
+}
+
+/* back */
+static void handle_f5(int *key, struct menu *current_item)
+{
+	*key = KEY_LEFT;
+	return;
+}
+
+/* save */
+static void handle_f6(int *key, struct menu *current_item)
+{
+	conf_save();
+	return;
+}
+
+/* load */
+static void handle_f7(int *key, struct menu *current_item)
+{
+	conf_load();
+	return;
+}
+
+/* search */
+static void handle_f8(int *key, struct menu *current_item)
+{
+	search_conf();
+	return;
+}
+
+/* exit */
+static void handle_f9(int *key, struct menu *current_item)
+{
+	do_exit();
+	return;
+}
+
+/* return != 0 to indicate the key was handles */
+static int process_special_keys(int *key, struct menu *menu)
+{
+	int i;
+
+	if (*key == KEY_RESIZE) {
+		setup_windows();
+		return 1;
+	}
+
+	for (i = 0; i < function_keys_num; i++) {
+		if (*key == KEY_F(function_keys[i].key) ||
+		    *key == '0' + function_keys[i].key){
+			function_keys[i].handler(key, menu);
+			return 1;
+		}
+	}
+
+	return 0;
+}
+
+static void clean_items(void)
+{
+	int i;
+	for (i = 0; curses_menu_items[i]; i++)
+		free_item(curses_menu_items[i]);
+	bzero(curses_menu_items, sizeof(curses_menu_items));
+	bzero(k_menu_items, sizeof(k_menu_items));
+	items_num = 0;
+}
+
+typedef enum {MATCH_TINKER_PATTERN_UP, MATCH_TINKER_PATTERN_DOWN,
+	FIND_NEXT_MATCH_DOWN, FIND_NEXT_MATCH_UP} match_f;
+
+/* return the index of the matched item, or -1 if no such item exists */
+static int get_mext_match(const char *match_str, match_f flag)
+{
+	int match_start, index;
+
+	/* Do not search if the menu is empty (i.e. items_num == 0) */
+	match_start = item_index(current_item(curses_menu));
+	if (match_start == ERR)
+		return -1;
+
+	if (flag == FIND_NEXT_MATCH_DOWN)
+		++match_start;
+	else if (flag == FIND_NEXT_MATCH_UP)
+		--match_start;
+
+	match_start = (match_start + items_num) % items_num;
+	index = match_start;
+	while (true) {
+		char *str = k_menu_items[index].str;
+		if (strcasestr(str, match_str) != NULL)
+			return index;
+		if (flag == FIND_NEXT_MATCH_UP ||
+		    flag == MATCH_TINKER_PATTERN_UP)
+			--index;
+		else
+			++index;
+		index = (index + items_num) % items_num;
+		if (index == match_start)
+			return -1;
+	}
+}
+
+/* Make a new item. */
+static void item_make(struct menu *menu, char tag, const char *fmt, ...)
+{
+	va_list ap;
+
+	if (items_num > MAX_MENU_ITEMS-1)
+		return;
+
+	bzero(&k_menu_items[items_num], sizeof(k_menu_items[0]));
+	k_menu_items[items_num].tag = tag;
+	k_menu_items[items_num].usrptr = menu;
+	if (menu != NULL)
+		k_menu_items[items_num].is_visible =
+			menu_is_visible(menu);
+	else
+		k_menu_items[items_num].is_visible = 1;
+
+	va_start(ap, fmt);
+	vsnprintf(k_menu_items[items_num].str,
+		  sizeof(k_menu_items[items_num].str),
+		  fmt, ap);
+	va_end(ap);
+
+	if (!k_menu_items[items_num].is_visible)
+		memcpy(k_menu_items[items_num].str, "XXX", 3);
+
+	curses_menu_items[items_num] = new_item(
+			k_menu_items[items_num].str,
+			k_menu_items[items_num].str);
+	set_item_userptr(curses_menu_items[items_num],
+			&k_menu_items[items_num]);
+	/*
+	if (!k_menu_items[items_num].is_visible)
+		item_opts_off(curses_menu_items[items_num], O_SELECTABLE);
+	*/
+
+	items_num++;
+	curses_menu_items[items_num] = NULL;
+}
+
+/* very hackish. adds a string to the last item added */
+static void item_add_str(const char *fmt, ...)
+{
+	va_list ap;
+	int index = items_num-1;
+	char new_str[256];
+	char tmp_str[256];
+
+	if (index < 0)
+		return;
+
+	va_start(ap, fmt);
+	vsnprintf(new_str, sizeof(new_str), fmt, ap);
+	va_end(ap);
+	snprintf(tmp_str, sizeof(tmp_str), "%s%s",
+			k_menu_items[index].str, new_str);
+	strncpy(k_menu_items[index].str,
+		tmp_str,
+		sizeof(k_menu_items[index].str));
+
+	free_item(curses_menu_items[index]);
+	curses_menu_items[index] = new_item(
+			k_menu_items[index].str,
+			k_menu_items[index].str);
+	set_item_userptr(curses_menu_items[index],
+			&k_menu_items[index]);
+}
+
+/* get the tag of the currently selected item */
+static char item_tag(void)
+{
+	ITEM *cur;
+	struct mitem *mcur;
+
+	cur = current_item(curses_menu);
+	if (cur == NULL)
+		return 0;
+	mcur = (struct mitem *) item_userptr(cur);
+	return mcur->tag;
+}
+
+static int curses_item_index(void)
+{
+	return  item_index(current_item(curses_menu));
+}
+
+static void *item_data(void)
+{
+	ITEM *cur;
+	struct mitem *mcur;
+
+	cur = current_item(curses_menu);
+	if (!cur)
+		return NULL;
+	mcur = (struct mitem *) item_userptr(cur);
+	return mcur->usrptr;
+
+}
+
+static int item_is_tag(char tag)
+{
+	return item_tag() == tag;
+}
+
+static char filename[PATH_MAX+1];
+static char menu_backtitle[PATH_MAX+128];
+static void set_config_filename(const char *config_filename)
+{
+	snprintf(menu_backtitle, sizeof(menu_backtitle), "%s - %s",
+		 config_filename, rootmenu.prompt->text);
+
+	snprintf(filename, sizeof(filename), "%s", config_filename);
+}
+
+/* return = 0 means we are successful.
+ * -1 means go on doing what you were doing
+ */
+static int do_exit(void)
+{
+	int res;
+	if (!conf_get_changed()) {
+		global_exit = 1;
+		return 0;
+	}
+	res = btn_dialog(main_window,
+			"Do you wish to save your new configuration?\n"
+				"<ESC> to cancel and resume nconfig.",
+			2,
+			"   <save>   ",
+			"<don't save>");
+	if (res == KEY_EXIT) {
+		global_exit = 0;
+		return -1;
+	}
+
+	/* if we got here, the user really wants to exit */
+	switch (res) {
+	case 0:
+		res = conf_write(filename);
+		if (res)
+			btn_dialog(
+				main_window,
+				"Error during writing of configuration.\n"
+				  "Your configuration changes were NOT saved.",
+				  1,
+				  "<OK>");
+		conf_write_autoconf(0);
+		break;
+	default:
+		btn_dialog(
+			main_window,
+			"Your configuration changes were NOT saved.",
+			1,
+			"<OK>");
+		break;
+	}
+	global_exit = 1;
+	return 0;
+}
+
+
+static void search_conf(void)
+{
+	struct symbol **sym_arr;
+	struct gstr res;
+	struct gstr title;
+	char *dialog_input;
+	int dres;
+
+	title = str_new();
+	str_printf( &title, "Enter (sub)string or regexp to search for "
+			      "(with or without \"%s\")", CONFIG_);
+
+again:
+	dres = dialog_inputbox(main_window,
+			"Search Configuration Parameter",
+			str_get(&title),
+			"", &dialog_input_result, &dialog_input_result_len);
+	switch (dres) {
+	case 0:
+		break;
+	case 1:
+		show_scroll_win(main_window,
+				"Search Configuration", search_help);
+		goto again;
+	default:
+		str_free(&title);
+		return;
+	}
+
+	/* strip the prefix if necessary */
+	dialog_input = dialog_input_result;
+	if (strncasecmp(dialog_input_result, CONFIG_, strlen(CONFIG_)) == 0)
+		dialog_input += strlen(CONFIG_);
+
+	sym_arr = sym_re_search(dialog_input);
+	res = get_relations_str(sym_arr, NULL);
+	free(sym_arr);
+	show_scroll_win(main_window,
+			"Search Results", str_get(&res));
+	str_free(&res);
+	str_free(&title);
+}
+
+
+static void build_conf(struct menu *menu)
+{
+	struct symbol *sym;
+	struct property *prop;
+	struct menu *child;
+	int type, tmp, doint = 2;
+	tristate val;
+	char ch;
+
+	if (!menu || (!show_all_items && !menu_is_visible(menu)))
+		return;
+
+	sym = menu->sym;
+	prop = menu->prompt;
+	if (!sym) {
+		if (prop && menu != current_menu) {
+			const char *prompt = menu_get_prompt(menu);
+			enum prop_type ptype;
+			ptype = menu->prompt ? menu->prompt->type : P_UNKNOWN;
+			switch (ptype) {
+			case P_MENU:
+				child_count++;
+				if (single_menu_mode) {
+					item_make(menu, 'm',
+						"%s%*c%s",
+						menu->data ? "-->" : "++>",
+						indent + 1, ' ', prompt);
+				} else
+					item_make(menu, 'm',
+						  "   %*c%s  %s",
+						  indent + 1, ' ', prompt,
+						  menu_is_empty(menu) ? "----" : "--->");
+
+				if (single_menu_mode && menu->data)
+					goto conf_childs;
+				return;
+			case P_COMMENT:
+				if (prompt) {
+					child_count++;
+					item_make(menu, ':',
+						"   %*c*** %s ***",
+						indent + 1, ' ',
+						prompt);
+				}
+				break;
+			default:
+				if (prompt) {
+					child_count++;
+					item_make(menu, ':', "---%*c%s",
+						indent + 1, ' ',
+						prompt);
+				}
+			}
+		} else
+			doint = 0;
+		goto conf_childs;
+	}
+
+	type = sym_get_type(sym);
+	if (sym_is_choice(sym)) {
+		struct symbol *def_sym = sym_get_choice_value(sym);
+		struct menu *def_menu = NULL;
+
+		child_count++;
+		for (child = menu->list; child; child = child->next) {
+			if (menu_is_visible(child) && child->sym == def_sym)
+				def_menu = child;
+		}
+
+		val = sym_get_tristate_value(sym);
+		if (sym_is_changeable(sym)) {
+			switch (type) {
+			case S_BOOLEAN:
+				item_make(menu, 't', "[%c]",
+						val == no ? ' ' : '*');
+				break;
+			case S_TRISTATE:
+				switch (val) {
+				case yes:
+					ch = '*';
+					break;
+				case mod:
+					ch = 'M';
+					break;
+				default:
+					ch = ' ';
+					break;
+				}
+				item_make(menu, 't', "<%c>", ch);
+				break;
+			}
+		} else {
+			item_make(menu, def_menu ? 't' : ':', "   ");
+		}
+
+		item_add_str("%*c%s", indent + 1,
+				' ', menu_get_prompt(menu));
+		if (val == yes) {
+			if (def_menu) {
+				item_add_str(" (%s)",
+					menu_get_prompt(def_menu));
+				item_add_str("  --->");
+				if (def_menu->list) {
+					indent += 2;
+					build_conf(def_menu);
+					indent -= 2;
+				}
+			}
+			return;
+		}
+	} else {
+		if (menu == current_menu) {
+			item_make(menu, ':',
+				"---%*c%s", indent + 1,
+				' ', menu_get_prompt(menu));
+			goto conf_childs;
+		}
+		child_count++;
+		val = sym_get_tristate_value(sym);
+		if (sym_is_choice_value(sym) && val == yes) {
+			item_make(menu, ':', "   ");
+		} else {
+			switch (type) {
+			case S_BOOLEAN:
+				if (sym_is_changeable(sym))
+					item_make(menu, 't', "[%c]",
+						val == no ? ' ' : '*');
+				else
+					item_make(menu, 't', "-%c-",
+						val == no ? ' ' : '*');
+				break;
+			case S_TRISTATE:
+				switch (val) {
+				case yes:
+					ch = '*';
+					break;
+				case mod:
+					ch = 'M';
+					break;
+				default:
+					ch = ' ';
+					break;
+				}
+				if (sym_is_changeable(sym)) {
+					if (sym->rev_dep.tri == mod)
+						item_make(menu,
+							't', "{%c}", ch);
+					else
+						item_make(menu,
+							't', "<%c>", ch);
+				} else
+					item_make(menu, 't', "-%c-", ch);
+				break;
+			default:
+				tmp = 2 + strlen(sym_get_string_value(sym));
+				item_make(menu, 's', "    (%s)",
+						sym_get_string_value(sym));
+				tmp = indent - tmp + 4;
+				if (tmp < 0)
+					tmp = 0;
+				item_add_str("%*c%s%s", tmp, ' ',
+						menu_get_prompt(menu),
+						(sym_has_value(sym) ||
+						 !sym_is_changeable(sym)) ? "" :
+						" (NEW)");
+				goto conf_childs;
+			}
+		}
+		item_add_str("%*c%s%s", indent + 1, ' ',
+				menu_get_prompt(menu),
+				(sym_has_value(sym) || !sym_is_changeable(sym)) ?
+				"" : " (NEW)");
+		if (menu->prompt && menu->prompt->type == P_MENU) {
+			item_add_str("  %s", menu_is_empty(menu) ? "----" : "--->");
+			return;
+		}
+	}
+
+conf_childs:
+	indent += doint;
+	for (child = menu->list; child; child = child->next)
+		build_conf(child);
+	indent -= doint;
+}
+
+static void reset_menu(void)
+{
+	unpost_menu(curses_menu);
+	clean_items();
+}
+
+/* adjust the menu to show this item.
+ * prefer not to scroll the menu if possible*/
+static void center_item(int selected_index, int *last_top_row)
+{
+	int toprow;
+
+	set_top_row(curses_menu, *last_top_row);
+	toprow = top_row(curses_menu);
+	if (selected_index < toprow ||
+	    selected_index >= toprow+mwin_max_lines) {
+		toprow = max(selected_index-mwin_max_lines/2, 0);
+		if (toprow >= item_count(curses_menu)-mwin_max_lines)
+			toprow = item_count(curses_menu)-mwin_max_lines;
+		set_top_row(curses_menu, toprow);
+	}
+	set_current_item(curses_menu,
+			curses_menu_items[selected_index]);
+	*last_top_row = toprow;
+	post_menu(curses_menu);
+	refresh_all_windows(main_window);
+}
+
+/* this function assumes reset_menu has been called before */
+static void show_menu(const char *prompt, const char *instructions,
+		int selected_index, int *last_top_row)
+{
+	int maxx, maxy;
+	WINDOW *menu_window;
+
+	current_instructions = instructions;
+
+	clear();
+	print_in_middle(stdscr, 1, getmaxx(stdscr),
+			menu_backtitle,
+			attr_main_heading);
+
+	wattrset(main_window, attr_main_menu_box);
+	box(main_window, 0, 0);
+	wattrset(main_window, attr_main_menu_heading);
+	mvwprintw(main_window, 0, 3, " %s ", prompt);
+	wattrset(main_window, attr_normal);
+
+	set_menu_items(curses_menu, curses_menu_items);
+
+	/* position the menu at the middle of the screen */
+	scale_menu(curses_menu, &maxy, &maxx);
+	maxx = min(maxx, mwin_max_cols-2);
+	maxy = mwin_max_lines;
+	menu_window = derwin(main_window,
+			maxy,
+			maxx,
+			2,
+			(mwin_max_cols-maxx)/2);
+	keypad(menu_window, TRUE);
+	set_menu_win(curses_menu, menu_window);
+	set_menu_sub(curses_menu, menu_window);
+
+	/* must reassert this after changing items, otherwise returns to a
+	 * default of 16
+	 */
+	set_menu_format(curses_menu, maxy, 1);
+	center_item(selected_index, last_top_row);
+	set_menu_format(curses_menu, maxy, 1);
+
+	print_function_line();
+
+	/* Post the menu */
+	post_menu(curses_menu);
+	refresh_all_windows(main_window);
+}
+
+static void adj_match_dir(match_f *match_direction)
+{
+	if (*match_direction == FIND_NEXT_MATCH_DOWN)
+		*match_direction =
+			MATCH_TINKER_PATTERN_DOWN;
+	else if (*match_direction == FIND_NEXT_MATCH_UP)
+		*match_direction =
+			MATCH_TINKER_PATTERN_UP;
+	/* else, do no change.. */
+}
+
+struct match_state
+{
+	int in_search;
+	match_f match_direction;
+	char pattern[256];
+};
+
+/* Return 0 means I have handled the key. In such a case, ans should hold the
+ * item to center, or -1 otherwise.
+ * Else return -1 .
+ */
+static int do_match(int key, struct match_state *state, int *ans)
+{
+	char c = (char) key;
+	int terminate_search = 0;
+	*ans = -1;
+	if (key == '/' || (state->in_search && key == 27)) {
+		move(0, 0);
+		refresh();
+		clrtoeol();
+		state->in_search = 1-state->in_search;
+		bzero(state->pattern, sizeof(state->pattern));
+		state->match_direction = MATCH_TINKER_PATTERN_DOWN;
+		return 0;
+	} else if (!state->in_search)
+		return 1;
+
+	if (isalnum(c) || isgraph(c) || c == ' ') {
+		state->pattern[strlen(state->pattern)] = c;
+		state->pattern[strlen(state->pattern)] = '\0';
+		adj_match_dir(&state->match_direction);
+		*ans = get_mext_match(state->pattern,
+				state->match_direction);
+	} else if (key == KEY_DOWN) {
+		state->match_direction = FIND_NEXT_MATCH_DOWN;
+		*ans = get_mext_match(state->pattern,
+				state->match_direction);
+	} else if (key == KEY_UP) {
+		state->match_direction = FIND_NEXT_MATCH_UP;
+		*ans = get_mext_match(state->pattern,
+				state->match_direction);
+	} else if (key == KEY_BACKSPACE || key == 8 || key == 127) {
+		state->pattern[strlen(state->pattern)-1] = '\0';
+		adj_match_dir(&state->match_direction);
+	} else
+		terminate_search = 1;
+
+	if (terminate_search) {
+		state->in_search = 0;
+		bzero(state->pattern, sizeof(state->pattern));
+		move(0, 0);
+		refresh();
+		clrtoeol();
+		return -1;
+	}
+	return 0;
+}
+
+static void conf(struct menu *menu)
+{
+	struct menu *submenu = NULL;
+	struct symbol *sym;
+	int res;
+	int current_index = 0;
+	int last_top_row = 0;
+	struct match_state match_state = {
+		.in_search = 0,
+		.match_direction = MATCH_TINKER_PATTERN_DOWN,
+		.pattern = "",
+	};
+
+	while (!global_exit) {
+		reset_menu();
+		current_menu = menu;
+		build_conf(menu);
+		if (!child_count)
+			break;
+
+		show_menu(menu_get_prompt(menu), menu_instructions,
+			  current_index, &last_top_row);
+		keypad((menu_win(curses_menu)), TRUE);
+		while (!global_exit) {
+			if (match_state.in_search) {
+				mvprintw(0, 0,
+					"searching: %s", match_state.pattern);
+				clrtoeol();
+			}
+			refresh_all_windows(main_window);
+			res = wgetch(menu_win(curses_menu));
+			if (!res)
+				break;
+			if (do_match(res, &match_state, &current_index) == 0) {
+				if (current_index != -1)
+					center_item(current_index,
+						    &last_top_row);
+				continue;
+			}
+			if (process_special_keys(&res,
+						(struct menu *) item_data()))
+				break;
+			switch (res) {
+			case KEY_DOWN:
+				menu_driver(curses_menu, REQ_DOWN_ITEM);
+				break;
+			case KEY_UP:
+				menu_driver(curses_menu, REQ_UP_ITEM);
+				break;
+			case KEY_NPAGE:
+				menu_driver(curses_menu, REQ_SCR_DPAGE);
+				break;
+			case KEY_PPAGE:
+				menu_driver(curses_menu, REQ_SCR_UPAGE);
+				break;
+			case KEY_HOME:
+				menu_driver(curses_menu, REQ_FIRST_ITEM);
+				break;
+			case KEY_END:
+				menu_driver(curses_menu, REQ_LAST_ITEM);
+				break;
+			case 'h':
+			case '?':
+				show_help((struct menu *) item_data());
+				break;
+			}
+			if (res == 10 || res == 27 ||
+				res == 32 || res == 'n' || res == 'y' ||
+				res == KEY_LEFT || res == KEY_RIGHT ||
+				res == 'm')
+				break;
+			refresh_all_windows(main_window);
+		}
+
+		refresh_all_windows(main_window);
+		/* if ESC or left*/
+		if (res == 27 || (menu != &rootmenu && res == KEY_LEFT))
+			break;
+
+		/* remember location in the menu */
+		last_top_row = top_row(curses_menu);
+		current_index = curses_item_index();
+
+		if (!item_tag())
+			continue;
+
+		submenu = (struct menu *) item_data();
+		if (!submenu || !menu_is_visible(submenu))
+			continue;
+		sym = submenu->sym;
+
+		switch (res) {
+		case ' ':
+			if (item_is_tag('t'))
+				sym_toggle_tristate_value(sym);
+			else if (item_is_tag('m'))
+				conf(submenu);
+			break;
+		case KEY_RIGHT:
+		case 10: /* ENTER WAS PRESSED */
+			switch (item_tag()) {
+			case 'm':
+				if (single_menu_mode)
+					submenu->data =
+						(void *) (long) !submenu->data;
+				else
+					conf(submenu);
+				break;
+			case 't':
+				if (sym_is_choice(sym) &&
+				    sym_get_tristate_value(sym) == yes)
+					conf_choice(submenu);
+				else if (submenu->prompt &&
+					 submenu->prompt->type == P_MENU)
+					conf(submenu);
+				else if (res == 10)
+					sym_toggle_tristate_value(sym);
+				break;
+			case 's':
+				conf_string(submenu);
+				break;
+			}
+			break;
+		case 'y':
+			if (item_is_tag('t')) {
+				if (sym_set_tristate_value(sym, yes))
+					break;
+				if (sym_set_tristate_value(sym, mod))
+					btn_dialog(main_window, setmod_text, 0);
+			}
+			break;
+		case 'n':
+			if (item_is_tag('t'))
+				sym_set_tristate_value(sym, no);
+			break;
+		case 'm':
+			if (item_is_tag('t'))
+				sym_set_tristate_value(sym, mod);
+			break;
+		}
+	}
+}
+
+static void conf_message_callback(const char *s)
+{
+	btn_dialog(main_window, s, 1, "<OK>");
+}
+
+static void show_help(struct menu *menu)
+{
+	struct gstr help;
+
+	if (!menu)
+		return;
+
+	help = str_new();
+	menu_get_ext_help(menu, &help);
+	show_scroll_win(main_window, menu_get_prompt(menu), str_get(&help));
+	str_free(&help);
+}
+
+static void conf_choice(struct menu *menu)
+{
+	const char *prompt = menu_get_prompt(menu);
+	struct menu *child = NULL;
+	struct symbol *active;
+	int selected_index = 0;
+	int last_top_row = 0;
+	int res, i = 0;
+	struct match_state match_state = {
+		.in_search = 0,
+		.match_direction = MATCH_TINKER_PATTERN_DOWN,
+		.pattern = "",
+	};
+
+	active = sym_get_choice_value(menu->sym);
+	/* this is mostly duplicated from the conf() function. */
+	while (!global_exit) {
+		reset_menu();
+
+		for (i = 0, child = menu->list; child; child = child->next) {
+			if (!show_all_items && !menu_is_visible(child))
+				continue;
+
+			if (child->sym == sym_get_choice_value(menu->sym))
+				item_make(child, ':', "<X> %s",
+						menu_get_prompt(child));
+			else if (child->sym)
+				item_make(child, ':', "    %s",
+						menu_get_prompt(child));
+			else
+				item_make(child, ':', "*** %s ***",
+						menu_get_prompt(child));
+
+			if (child->sym == active){
+				last_top_row = top_row(curses_menu);
+				selected_index = i;
+			}
+			i++;
+		}
+		show_menu(prompt ? prompt : "Choice Menu",
+				radiolist_instructions,
+				selected_index,
+				&last_top_row);
+		while (!global_exit) {
+			if (match_state.in_search) {
+				mvprintw(0, 0, "searching: %s",
+					 match_state.pattern);
+				clrtoeol();
+			}
+			refresh_all_windows(main_window);
+			res = wgetch(menu_win(curses_menu));
+			if (!res)
+				break;
+			if (do_match(res, &match_state, &selected_index) == 0) {
+				if (selected_index != -1)
+					center_item(selected_index,
+						    &last_top_row);
+				continue;
+			}
+			if (process_special_keys(
+						&res,
+						(struct menu *) item_data()))
+				break;
+			switch (res) {
+			case KEY_DOWN:
+				menu_driver(curses_menu, REQ_DOWN_ITEM);
+				break;
+			case KEY_UP:
+				menu_driver(curses_menu, REQ_UP_ITEM);
+				break;
+			case KEY_NPAGE:
+				menu_driver(curses_menu, REQ_SCR_DPAGE);
+				break;
+			case KEY_PPAGE:
+				menu_driver(curses_menu, REQ_SCR_UPAGE);
+				break;
+			case KEY_HOME:
+				menu_driver(curses_menu, REQ_FIRST_ITEM);
+				break;
+			case KEY_END:
+				menu_driver(curses_menu, REQ_LAST_ITEM);
+				break;
+			case 'h':
+			case '?':
+				show_help((struct menu *) item_data());
+				break;
+			}
+			if (res == 10 || res == 27 || res == ' ' ||
+					res == KEY_LEFT){
+				break;
+			}
+			refresh_all_windows(main_window);
+		}
+		/* if ESC or left */
+		if (res == 27 || res == KEY_LEFT)
+			break;
+
+		child = item_data();
+		if (!child || !menu_is_visible(child) || !child->sym)
+			continue;
+		switch (res) {
+		case ' ':
+		case  10:
+		case KEY_RIGHT:
+			sym_set_tristate_value(child->sym, yes);
+			return;
+		case 'h':
+		case '?':
+			show_help(child);
+			active = child->sym;
+			break;
+		case KEY_EXIT:
+			return;
+		}
+	}
+}
+
+static void conf_string(struct menu *menu)
+{
+	const char *prompt = menu_get_prompt(menu);
+
+	while (1) {
+		int res;
+		const char *heading;
+
+		switch (sym_get_type(menu->sym)) {
+		case S_INT:
+			heading = inputbox_instructions_int;
+			break;
+		case S_HEX:
+			heading = inputbox_instructions_hex;
+			break;
+		case S_STRING:
+			heading = inputbox_instructions_string;
+			break;
+		default:
+			heading = "Internal nconf error!";
+		}
+		res = dialog_inputbox(main_window,
+				prompt ? prompt : "Main Menu",
+				heading,
+				sym_get_string_value(menu->sym),
+				&dialog_input_result,
+				&dialog_input_result_len);
+		switch (res) {
+		case 0:
+			if (sym_set_string_value(menu->sym,
+						dialog_input_result))
+				return;
+			btn_dialog(main_window,
+				"You have made an invalid entry.", 0);
+			break;
+		case 1:
+			show_help(menu);
+			break;
+		case KEY_EXIT:
+			return;
+		}
+	}
+}
+
+static void conf_load(void)
+{
+	while (1) {
+		int res;
+		res = dialog_inputbox(main_window,
+				NULL, load_config_text,
+				filename,
+				&dialog_input_result,
+				&dialog_input_result_len);
+		switch (res) {
+		case 0:
+			if (!dialog_input_result[0])
+				return;
+			if (!conf_read(dialog_input_result)) {
+				set_config_filename(dialog_input_result);
+				conf_set_changed(true);
+				return;
+			}
+			btn_dialog(main_window, "File does not exist!", 0);
+			break;
+		case 1:
+			show_scroll_win(main_window,
+					"Load Alternate Configuration",
+					load_config_help);
+			break;
+		case KEY_EXIT:
+			return;
+		}
+	}
+}
+
+static void conf_save(void)
+{
+	while (1) {
+		int res;
+		res = dialog_inputbox(main_window,
+				NULL, save_config_text,
+				filename,
+				&dialog_input_result,
+				&dialog_input_result_len);
+		switch (res) {
+		case 0:
+			if (!dialog_input_result[0])
+				return;
+			res = conf_write(dialog_input_result);
+			if (!res) {
+				set_config_filename(dialog_input_result);
+				return;
+			}
+			btn_dialog(main_window, "Can't create file!",
+				1, "<OK>");
+			break;
+		case 1:
+			show_scroll_win(main_window,
+				"Save Alternate Configuration",
+				save_config_help);
+			break;
+		case KEY_EXIT:
+			return;
+		}
+	}
+}
+
+static void setup_windows(void)
+{
+	int lines, columns;
+
+	getmaxyx(stdscr, lines, columns);
+
+	if (main_window != NULL)
+		delwin(main_window);
+
+	/* set up the menu and menu window */
+	main_window = newwin(lines-2, columns-2, 2, 1);
+	keypad(main_window, TRUE);
+	mwin_max_lines = lines-7;
+	mwin_max_cols = columns-6;
+
+	/* panels order is from bottom to top */
+	new_panel(main_window);
+}
+
+int main(int ac, char **av)
+{
+	int lines, columns;
+	char *mode;
+
+	if (ac > 1 && strcmp(av[1], "-s") == 0) {
+		/* Silence conf_read() until the real callback is set up */
+		conf_set_message_callback(NULL);
+		av++;
+	}
+	conf_parse(av[1]);
+	conf_read(NULL);
+
+	mode = getenv("NCONFIG_MODE");
+	if (mode) {
+		if (!strcasecmp(mode, "single_menu"))
+			single_menu_mode = 1;
+	}
+
+	/* Initialize curses */
+	initscr();
+	/* set color theme */
+	set_colors();
+
+	cbreak();
+	noecho();
+	keypad(stdscr, TRUE);
+	curs_set(0);
+
+	getmaxyx(stdscr, lines, columns);
+	if (columns < 75 || lines < 20) {
+		endwin();
+		printf("Your terminal should have at "
+			"least 20 lines and 75 columns\n");
+		return 1;
+	}
+
+	notimeout(stdscr, FALSE);
+#if NCURSES_REENTRANT
+	set_escdelay(1);
+#else
+	ESCDELAY = 1;
+#endif
+
+	/* set btns menu */
+	curses_menu = new_menu(curses_menu_items);
+	menu_opts_off(curses_menu, O_SHOWDESC);
+	menu_opts_on(curses_menu, O_SHOWMATCH);
+	menu_opts_on(curses_menu, O_ONEVALUE);
+	menu_opts_on(curses_menu, O_NONCYCLIC);
+	menu_opts_on(curses_menu, O_IGNORECASE);
+	set_menu_mark(curses_menu, " ");
+	set_menu_fore(curses_menu, attr_main_menu_fore);
+	set_menu_back(curses_menu, attr_main_menu_back);
+	set_menu_grey(curses_menu, attr_main_menu_grey);
+
+	set_config_filename(conf_get_configname());
+	setup_windows();
+
+	/* check for KEY_FUNC(1) */
+	if (has_key(KEY_F(1)) == FALSE) {
+		show_scroll_win(main_window,
+				"Instructions",
+				menu_no_f_instructions);
+	}
+
+	conf_set_message_callback(conf_message_callback);
+	/* do the work */
+	while (!global_exit) {
+		conf(&rootmenu);
+		if (!global_exit && do_exit() == 0)
+			break;
+	}
+	/* ok, we are done */
+	unpost_menu(curses_menu);
+	free_menu(curses_menu);
+	delwin(main_window);
+	clear();
+	refresh();
+	endwin();
+	return 0;
+}
diff --git a/backport/kconf/nconf.gui.c b/backport/kconf/nconf.gui.c
new file mode 100644
index 000000000000..9aedf40f1dc0
--- /dev/null
+++ b/backport/kconf/nconf.gui.c
@@ -0,0 +1,614 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2008 Nir Tzachar <nir.tzachar@gmail.com>
+ *
+ * Derived from menuconfig.
+ */
+#include "nconf.h"
+#include "lkc.h"
+
+int attr_normal;
+int attr_main_heading;
+int attr_main_menu_box;
+int attr_main_menu_fore;
+int attr_main_menu_back;
+int attr_main_menu_grey;
+int attr_main_menu_heading;
+int attr_scrollwin_text;
+int attr_scrollwin_heading;
+int attr_scrollwin_box;
+int attr_dialog_text;
+int attr_dialog_menu_fore;
+int attr_dialog_menu_back;
+int attr_dialog_box;
+int attr_input_box;
+int attr_input_heading;
+int attr_input_text;
+int attr_input_field;
+int attr_function_text;
+int attr_function_highlight;
+
+#define COLOR_ATTR(_at, _fg, _bg, _hl) \
+	{ .attr = &(_at), .has_color = true, .color_fg = _fg, .color_bg = _bg, .highlight = _hl }
+#define NO_COLOR_ATTR(_at, _hl) \
+	{ .attr = &(_at), .has_color = false, .highlight = _hl }
+#define COLOR_DEFAULT		-1
+
+struct nconf_attr_param {
+	int *attr;
+	bool has_color;
+	int color_fg;
+	int color_bg;
+	int highlight;
+};
+
+static const struct nconf_attr_param color_theme_params[] = {
+	COLOR_ATTR(attr_normal,			COLOR_DEFAULT,	COLOR_DEFAULT,	A_NORMAL),
+	COLOR_ATTR(attr_main_heading,		COLOR_MAGENTA,	COLOR_DEFAULT,	A_BOLD | A_UNDERLINE),
+	COLOR_ATTR(attr_main_menu_box,		COLOR_YELLOW,	COLOR_DEFAULT,	A_NORMAL),
+	COLOR_ATTR(attr_main_menu_fore,		COLOR_DEFAULT,	COLOR_DEFAULT,	A_REVERSE),
+	COLOR_ATTR(attr_main_menu_back,		COLOR_DEFAULT,	COLOR_DEFAULT,	A_NORMAL),
+	COLOR_ATTR(attr_main_menu_grey,		COLOR_DEFAULT,	COLOR_DEFAULT,	A_NORMAL),
+	COLOR_ATTR(attr_main_menu_heading,	COLOR_GREEN,	COLOR_DEFAULT,	A_BOLD),
+	COLOR_ATTR(attr_scrollwin_text,		COLOR_DEFAULT,	COLOR_DEFAULT,	A_NORMAL),
+	COLOR_ATTR(attr_scrollwin_heading,	COLOR_GREEN,	COLOR_DEFAULT,	A_BOLD),
+	COLOR_ATTR(attr_scrollwin_box,		COLOR_YELLOW,	COLOR_DEFAULT,	A_BOLD),
+	COLOR_ATTR(attr_dialog_text,		COLOR_DEFAULT,	COLOR_DEFAULT,	A_BOLD),
+	COLOR_ATTR(attr_dialog_menu_fore,	COLOR_RED,	COLOR_DEFAULT,	A_STANDOUT),
+	COLOR_ATTR(attr_dialog_menu_back,	COLOR_YELLOW,	COLOR_DEFAULT,	A_NORMAL),
+	COLOR_ATTR(attr_dialog_box,		COLOR_YELLOW,	COLOR_DEFAULT,	A_BOLD),
+	COLOR_ATTR(attr_input_box,		COLOR_YELLOW,	COLOR_DEFAULT,	A_NORMAL),
+	COLOR_ATTR(attr_input_heading,		COLOR_GREEN,	COLOR_DEFAULT,	A_BOLD),
+	COLOR_ATTR(attr_input_text,		COLOR_DEFAULT,	COLOR_DEFAULT,	A_NORMAL),
+	COLOR_ATTR(attr_input_field,		COLOR_DEFAULT,	COLOR_DEFAULT,	A_UNDERLINE),
+	COLOR_ATTR(attr_function_text,		COLOR_YELLOW,	COLOR_DEFAULT,	A_REVERSE),
+	COLOR_ATTR(attr_function_highlight,	COLOR_DEFAULT,	COLOR_DEFAULT,	A_BOLD),
+	{ /* sentinel */ }
+};
+
+static const struct nconf_attr_param no_color_theme_params[] = {
+	NO_COLOR_ATTR(attr_normal,		A_NORMAL),
+	NO_COLOR_ATTR(attr_main_heading,	A_BOLD | A_UNDERLINE),
+	NO_COLOR_ATTR(attr_main_menu_box,	A_NORMAL),
+	NO_COLOR_ATTR(attr_main_menu_fore,	A_STANDOUT),
+	NO_COLOR_ATTR(attr_main_menu_back,	A_NORMAL),
+	NO_COLOR_ATTR(attr_main_menu_grey,	A_NORMAL),
+	NO_COLOR_ATTR(attr_main_menu_heading,	A_BOLD),
+	NO_COLOR_ATTR(attr_scrollwin_text,	A_NORMAL),
+	NO_COLOR_ATTR(attr_scrollwin_heading,	A_BOLD),
+	NO_COLOR_ATTR(attr_scrollwin_box,	A_BOLD),
+	NO_COLOR_ATTR(attr_dialog_text,		A_NORMAL),
+	NO_COLOR_ATTR(attr_dialog_menu_fore,	A_STANDOUT),
+	NO_COLOR_ATTR(attr_dialog_menu_back,	A_NORMAL),
+	NO_COLOR_ATTR(attr_dialog_box,		A_BOLD),
+	NO_COLOR_ATTR(attr_input_box,		A_BOLD),
+	NO_COLOR_ATTR(attr_input_heading,	A_BOLD),
+	NO_COLOR_ATTR(attr_input_text,		A_NORMAL),
+	NO_COLOR_ATTR(attr_input_field,		A_UNDERLINE),
+	NO_COLOR_ATTR(attr_function_text,	A_REVERSE),
+	NO_COLOR_ATTR(attr_function_highlight,	A_BOLD),
+	{ /* sentinel */ }
+};
+
+void set_colors(void)
+{
+	const struct nconf_attr_param *p;
+	int pair = 0;
+
+	if (has_colors()) {
+		start_color();
+		use_default_colors();
+		p = color_theme_params;
+	} else {
+		p = no_color_theme_params;
+	}
+
+	for (; p->attr; p++) {
+		int attr = p->highlight;
+
+		if (p->has_color) {
+			pair++;
+			init_pair(pair, p->color_fg, p->color_bg);
+			attr |= COLOR_PAIR(pair);
+		}
+
+		*p->attr = attr;
+	}
+}
+
+/* this changes the windows attributes !!! */
+void print_in_middle(WINDOW *win, int y, int width, const char *str, int attrs)
+{
+	wattrset(win, attrs);
+	mvwprintw(win, y, (width - strlen(str)) / 2, "%s", str);
+}
+
+int get_line_no(const char *text)
+{
+	int i;
+	int total = 1;
+
+	if (!text)
+		return 0;
+
+	for (i = 0; text[i] != '\0'; i++)
+		if (text[i] == '\n')
+			total++;
+	return total;
+}
+
+const char *get_line(const char *text, int line_no)
+{
+	int i;
+	int lines = 0;
+
+	if (!text)
+		return NULL;
+
+	for (i = 0; text[i] != '\0' && lines < line_no; i++)
+		if (text[i] == '\n')
+			lines++;
+	return text+i;
+}
+
+int get_line_length(const char *line)
+{
+	int res = 0;
+	while (*line != '\0' && *line != '\n') {
+		line++;
+		res++;
+	}
+	return res;
+}
+
+/* print all lines to the window. */
+void fill_window(WINDOW *win, const char *text)
+{
+	int x, y;
+	int total_lines = get_line_no(text);
+	int i;
+
+	getmaxyx(win, y, x);
+	/* do not go over end of line */
+	total_lines = min(total_lines, y);
+	for (i = 0; i < total_lines; i++) {
+		char tmp[x+10];
+		const char *line = get_line(text, i);
+		int len = get_line_length(line);
+		strncpy(tmp, line, min(len, x));
+		tmp[len] = '\0';
+		mvwprintw(win, i, 0, "%s", tmp);
+	}
+}
+
+/* get the message, and buttons.
+ * each button must be a char*
+ * return the selected button
+ *
+ * this dialog is used for 2 different things:
+ * 1) show a text box, no buttons.
+ * 2) show a dialog, with horizontal buttons
+ */
+int btn_dialog(WINDOW *main_window, const char *msg, int btn_num, ...)
+{
+	va_list ap;
+	char *btn;
+	int btns_width = 0;
+	int msg_lines = 0;
+	int msg_width = 0;
+	int total_width;
+	int win_rows = 0;
+	WINDOW *win;
+	WINDOW *msg_win;
+	WINDOW *menu_win;
+	MENU *menu;
+	ITEM *btns[btn_num+1];
+	int i, x, y;
+	int res = -1;
+
+
+	va_start(ap, btn_num);
+	for (i = 0; i < btn_num; i++) {
+		btn = va_arg(ap, char *);
+		btns[i] = new_item(btn, "");
+		btns_width += strlen(btn)+1;
+	}
+	va_end(ap);
+	btns[btn_num] = NULL;
+
+	/* find the widest line of msg: */
+	msg_lines = get_line_no(msg);
+	for (i = 0; i < msg_lines; i++) {
+		const char *line = get_line(msg, i);
+		int len = get_line_length(line);
+		if (msg_width < len)
+			msg_width = len;
+	}
+
+	total_width = max(msg_width, btns_width);
+	/* place dialog in middle of screen */
+	y = (getmaxy(stdscr)-(msg_lines+4))/2;
+	x = (getmaxx(stdscr)-(total_width+4))/2;
+
+
+	/* create the windows */
+	if (btn_num > 0)
+		win_rows = msg_lines+4;
+	else
+		win_rows = msg_lines+2;
+
+	win = newwin(win_rows, total_width+4, y, x);
+	keypad(win, TRUE);
+	menu_win = derwin(win, 1, btns_width, win_rows-2,
+			1+(total_width+2-btns_width)/2);
+	menu = new_menu(btns);
+	msg_win = derwin(win, win_rows-2, msg_width, 1,
+			1+(total_width+2-msg_width)/2);
+
+	set_menu_fore(menu, attr_dialog_menu_fore);
+	set_menu_back(menu, attr_dialog_menu_back);
+
+	wattrset(win, attr_dialog_box);
+	box(win, 0, 0);
+
+	/* print message */
+	wattrset(msg_win, attr_dialog_text);
+	fill_window(msg_win, msg);
+
+	set_menu_win(menu, win);
+	set_menu_sub(menu, menu_win);
+	set_menu_format(menu, 1, btn_num);
+	menu_opts_off(menu, O_SHOWDESC);
+	menu_opts_off(menu, O_SHOWMATCH);
+	menu_opts_on(menu, O_ONEVALUE);
+	menu_opts_on(menu, O_NONCYCLIC);
+	set_menu_mark(menu, "");
+	post_menu(menu);
+
+
+	touchwin(win);
+	refresh_all_windows(main_window);
+	while ((res = wgetch(win))) {
+		switch (res) {
+		case KEY_LEFT:
+			menu_driver(menu, REQ_LEFT_ITEM);
+			break;
+		case KEY_RIGHT:
+			menu_driver(menu, REQ_RIGHT_ITEM);
+			break;
+		case 10: /* ENTER */
+		case 27: /* ESCAPE */
+		case ' ':
+		case KEY_F(F_BACK):
+		case KEY_F(F_EXIT):
+			break;
+		}
+		touchwin(win);
+		refresh_all_windows(main_window);
+
+		if (res == 10 || res == ' ') {
+			res = item_index(current_item(menu));
+			break;
+		} else if (res == 27 || res == KEY_F(F_BACK) ||
+				res == KEY_F(F_EXIT)) {
+			res = KEY_EXIT;
+			break;
+		}
+	}
+
+	unpost_menu(menu);
+	free_menu(menu);
+	for (i = 0; i < btn_num; i++)
+		free_item(btns[i]);
+
+	delwin(win);
+	return res;
+}
+
+int dialog_inputbox(WINDOW *main_window,
+		const char *title, const char *prompt,
+		const char *init, char **resultp, int *result_len)
+{
+	int prompt_lines = 0;
+	int prompt_width = 0;
+	WINDOW *win;
+	WINDOW *prompt_win;
+	WINDOW *form_win;
+	PANEL *panel;
+	int i, x, y, lines, columns, win_lines, win_cols;
+	int res = -1;
+	int cursor_position = strlen(init);
+	int cursor_form_win;
+	char *result = *resultp;
+
+	getmaxyx(stdscr, lines, columns);
+
+	if (strlen(init)+1 > *result_len) {
+		*result_len = strlen(init)+1;
+		*resultp = result = xrealloc(result, *result_len);
+	}
+
+	/* find the widest line of msg: */
+	prompt_lines = get_line_no(prompt);
+	for (i = 0; i < prompt_lines; i++) {
+		const char *line = get_line(prompt, i);
+		int len = get_line_length(line);
+		prompt_width = max(prompt_width, len);
+	}
+
+	if (title)
+		prompt_width = max(prompt_width, strlen(title));
+
+	win_lines = min(prompt_lines+6, lines-2);
+	win_cols = min(prompt_width+7, columns-2);
+	prompt_lines = max(win_lines-6, 0);
+	prompt_width = max(win_cols-7, 0);
+
+	/* place dialog in middle of screen */
+	y = (lines-win_lines)/2;
+	x = (columns-win_cols)/2;
+
+	strncpy(result, init, *result_len);
+
+	/* create the windows */
+	win = newwin(win_lines, win_cols, y, x);
+	prompt_win = derwin(win, prompt_lines+1, prompt_width, 2, 2);
+	form_win = derwin(win, 1, prompt_width, prompt_lines+3, 2);
+	keypad(form_win, TRUE);
+
+	wattrset(form_win, attr_input_field);
+
+	wattrset(win, attr_input_box);
+	box(win, 0, 0);
+	wattrset(win, attr_input_heading);
+	if (title)
+		mvwprintw(win, 0, 3, "%s", title);
+
+	/* print message */
+	wattrset(prompt_win, attr_input_text);
+	fill_window(prompt_win, prompt);
+
+	mvwprintw(form_win, 0, 0, "%*s", prompt_width, " ");
+	cursor_form_win = min(cursor_position, prompt_width-1);
+	mvwprintw(form_win, 0, 0, "%s",
+		  result + cursor_position-cursor_form_win);
+
+	/* create panels */
+	panel = new_panel(win);
+
+	/* show the cursor */
+	curs_set(1);
+
+	touchwin(win);
+	refresh_all_windows(main_window);
+	while ((res = wgetch(form_win))) {
+		int len = strlen(result);
+		switch (res) {
+		case 10: /* ENTER */
+		case 27: /* ESCAPE */
+		case KEY_F(F_HELP):
+		case KEY_F(F_EXIT):
+		case KEY_F(F_BACK):
+			break;
+		case 8:   /* ^H */
+		case 127: /* ^? */
+		case KEY_BACKSPACE:
+			if (cursor_position > 0) {
+				memmove(&result[cursor_position-1],
+						&result[cursor_position],
+						len-cursor_position+1);
+				cursor_position--;
+				cursor_form_win--;
+				len--;
+			}
+			break;
+		case KEY_DC:
+			if (cursor_position >= 0 && cursor_position < len) {
+				memmove(&result[cursor_position],
+						&result[cursor_position+1],
+						len-cursor_position+1);
+				len--;
+			}
+			break;
+		case KEY_UP:
+		case KEY_RIGHT:
+			if (cursor_position < len) {
+				cursor_position++;
+				cursor_form_win++;
+			}
+			break;
+		case KEY_DOWN:
+		case KEY_LEFT:
+			if (cursor_position > 0) {
+				cursor_position--;
+				cursor_form_win--;
+			}
+			break;
+		case KEY_HOME:
+			cursor_position = 0;
+			cursor_form_win = 0;
+			break;
+		case KEY_END:
+			cursor_position = len;
+			cursor_form_win = min(cursor_position, prompt_width-1);
+			break;
+		default:
+			if ((isgraph(res) || isspace(res))) {
+				/* one for new char, one for '\0' */
+				if (len+2 > *result_len) {
+					*result_len = len+2;
+					*resultp = result = realloc(result,
+								*result_len);
+				}
+				/* insert the char at the proper position */
+				memmove(&result[cursor_position+1],
+						&result[cursor_position],
+						len-cursor_position+1);
+				result[cursor_position] = res;
+				cursor_position++;
+				cursor_form_win++;
+				len++;
+			} else {
+				mvprintw(0, 0, "unknown key: %d\n", res);
+			}
+			break;
+		}
+		if (cursor_form_win < 0)
+			cursor_form_win = 0;
+		else if (cursor_form_win > prompt_width-1)
+			cursor_form_win = prompt_width-1;
+
+		wmove(form_win, 0, 0);
+		wclrtoeol(form_win);
+		mvwprintw(form_win, 0, 0, "%*s", prompt_width, " ");
+		mvwprintw(form_win, 0, 0, "%s",
+			result + cursor_position-cursor_form_win);
+		wmove(form_win, 0, cursor_form_win);
+		touchwin(win);
+		refresh_all_windows(main_window);
+
+		if (res == 10) {
+			res = 0;
+			break;
+		} else if (res == 27 || res == KEY_F(F_BACK) ||
+				res == KEY_F(F_EXIT)) {
+			res = KEY_EXIT;
+			break;
+		} else if (res == KEY_F(F_HELP)) {
+			res = 1;
+			break;
+		}
+	}
+
+	/* hide the cursor */
+	curs_set(0);
+	del_panel(panel);
+	delwin(prompt_win);
+	delwin(form_win);
+	delwin(win);
+	return res;
+}
+
+/* refresh all windows in the correct order */
+void refresh_all_windows(WINDOW *main_window)
+{
+	update_panels();
+	touchwin(main_window);
+	refresh();
+}
+
+/* layman's scrollable window... */
+void show_scroll_win(WINDOW *main_window,
+		const char *title,
+		const char *text)
+{
+	int res;
+	int total_lines = get_line_no(text);
+	int x, y, lines, columns;
+	int start_x = 0, start_y = 0;
+	int text_lines = 0, text_cols = 0;
+	int total_cols = 0;
+	int win_cols = 0;
+	int win_lines = 0;
+	int i = 0;
+	WINDOW *win;
+	WINDOW *pad;
+	PANEL *panel;
+
+	getmaxyx(stdscr, lines, columns);
+
+	/* find the widest line of msg: */
+	total_lines = get_line_no(text);
+	for (i = 0; i < total_lines; i++) {
+		const char *line = get_line(text, i);
+		int len = get_line_length(line);
+		total_cols = max(total_cols, len+2);
+	}
+
+	/* create the pad */
+	pad = newpad(total_lines+10, total_cols+10);
+	wattrset(pad, attr_scrollwin_text);
+	fill_window(pad, text);
+
+	win_lines = min(total_lines+4, lines-2);
+	win_cols = min(total_cols+2, columns-2);
+	text_lines = max(win_lines-4, 0);
+	text_cols = max(win_cols-2, 0);
+
+	/* place window in middle of screen */
+	y = (lines-win_lines)/2;
+	x = (columns-win_cols)/2;
+
+	win = newwin(win_lines, win_cols, y, x);
+	keypad(win, TRUE);
+	/* show the help in the help window, and show the help panel */
+	wattrset(win, attr_scrollwin_box);
+	box(win, 0, 0);
+	wattrset(win, attr_scrollwin_heading);
+	mvwprintw(win, 0, 3, " %s ", title);
+	panel = new_panel(win);
+
+	/* handle scrolling */
+	do {
+
+		copywin(pad, win, start_y, start_x, 2, 2, text_lines,
+				text_cols, 0);
+		print_in_middle(win,
+				text_lines+2,
+				text_cols,
+				"<OK>",
+				attr_dialog_menu_fore);
+		wrefresh(win);
+
+		res = wgetch(win);
+		switch (res) {
+		case KEY_NPAGE:
+		case ' ':
+		case 'd':
+			start_y += text_lines-2;
+			break;
+		case KEY_PPAGE:
+		case 'u':
+			start_y -= text_lines+2;
+			break;
+		case KEY_HOME:
+			start_y = 0;
+			break;
+		case KEY_END:
+			start_y = total_lines-text_lines;
+			break;
+		case KEY_DOWN:
+		case 'j':
+			start_y++;
+			break;
+		case KEY_UP:
+		case 'k':
+			start_y--;
+			break;
+		case KEY_LEFT:
+		case 'h':
+			start_x--;
+			break;
+		case KEY_RIGHT:
+		case 'l':
+			start_x++;
+			break;
+		}
+		if (res == 10 || res == 27 || res == 'q' ||
+			res == KEY_F(F_HELP) || res == KEY_F(F_BACK) ||
+			res == KEY_F(F_EXIT))
+			break;
+		if (start_y < 0)
+			start_y = 0;
+		if (start_y >= total_lines-text_lines)
+			start_y = total_lines-text_lines;
+		if (start_x < 0)
+			start_x = 0;
+		if (start_x >= total_cols-text_cols)
+			start_x = total_cols-text_cols;
+	} while (res);
+
+	del_panel(panel);
+	delwin(win);
+	refresh_all_windows(main_window);
+}
diff --git a/backport/kconf/nconf.h b/backport/kconf/nconf.h
new file mode 100644
index 000000000000..6f925bc74eb3
--- /dev/null
+++ b/backport/kconf/nconf.h
@@ -0,0 +1,83 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (C) 2008 Nir Tzachar <nir.tzachar@gmail.com>
+ *
+ * Derived from menuconfig.
+ */
+
+#include <ctype.h>
+#include <errno.h>
+#include <fcntl.h>
+#include <limits.h>
+#include <stdarg.h>
+#include <stdlib.h>
+#include <string.h>
+#include <unistd.h>
+#include <ncurses.h>
+#include <menu.h>
+#include <panel.h>
+#include <form.h>
+
+#include <stdio.h>
+#include <time.h>
+#include <sys/time.h>
+
+#define max(a, b) ({\
+		typeof(a) _a = a;\
+		typeof(b) _b = b;\
+		_a > _b ? _a : _b; })
+
+#define min(a, b) ({\
+		typeof(a) _a = a;\
+		typeof(b) _b = b;\
+		_a < _b ? _a : _b; })
+
+extern int attr_normal;
+extern int attr_main_heading;
+extern int attr_main_menu_box;
+extern int attr_main_menu_fore;
+extern int attr_main_menu_back;
+extern int attr_main_menu_grey;
+extern int attr_main_menu_heading;
+extern int attr_scrollwin_text;
+extern int attr_scrollwin_heading;
+extern int attr_scrollwin_box;
+extern int attr_dialog_text;
+extern int attr_dialog_menu_fore;
+extern int attr_dialog_menu_back;
+extern int attr_dialog_box;
+extern int attr_input_box;
+extern int attr_input_heading;
+extern int attr_input_text;
+extern int attr_input_field;
+extern int attr_function_text;
+extern int attr_function_highlight;
+
+typedef enum {
+	F_HELP = 1,
+	F_SYMBOL = 2,
+	F_INSTS = 3,
+	F_CONF = 4,
+	F_BACK = 5,
+	F_SAVE = 6,
+	F_LOAD = 7,
+	F_SEARCH = 8,
+	F_EXIT = 9,
+} function_key;
+
+void set_colors(void);
+
+/* this changes the windows attributes !!! */
+void print_in_middle(WINDOW *win, int y, int width, const char *str, int attrs);
+int get_line_length(const char *line);
+int get_line_no(const char *text);
+const char *get_line(const char *text, int line_no);
+void fill_window(WINDOW *win, const char *text);
+int btn_dialog(WINDOW *main_window, const char *msg, int btn_num, ...);
+int dialog_inputbox(WINDOW *main_window,
+		const char *title, const char *prompt,
+		const char *init, char **resultp, int *result_len);
+void refresh_all_windows(WINDOW *main_window);
+void show_scroll_win(WINDOW *main_window,
+		const char *title,
+		const char *text);
diff --git a/backport/kconf/parser.y b/backport/kconf/parser.y
new file mode 100644
index 000000000000..2af7ce4e1531
--- /dev/null
+++ b/backport/kconf/parser.y
@@ -0,0 +1,716 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (C) 2002 Roman Zippel <zippel@linux-m68k.org>
+ */
+%{
+
+#include <ctype.h>
+#include <stdarg.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+#include <stdbool.h>
+
+#include "lkc.h"
+#include "internal.h"
+
+#define printd(mask, fmt...) if (cdebug & (mask)) printf(fmt)
+
+#define PRINTD		0x0001
+#define DEBUG_PARSE	0x0002
+
+int cdebug = PRINTD;
+
+static void yyerror(const char *err);
+static void zconfprint(const char *err, ...);
+static void zconf_error(const char *err, ...);
+static bool zconf_endtoken(const char *tokenname,
+			   const char *expected_tokenname);
+
+struct symbol *symbol_hash[SYMBOL_HASHSIZE];
+
+struct menu *current_menu, *current_entry;
+
+%}
+
+%union
+{
+	char *string;
+	struct symbol *symbol;
+	struct expr *expr;
+	struct menu *menu;
+	enum symbol_type type;
+	enum variable_flavor flavor;
+}
+
+%token <string> T_HELPTEXT
+%token <string> T_WORD
+%token <string> T_WORD_QUOTE
+%token T_BOOL
+%token T_CHOICE
+%token T_CLOSE_PAREN
+%token T_COLON_EQUAL
+%token T_COMMENT
+%token T_CONFIG
+%token T_DEFAULT
+%token T_DEF_BOOL
+%token T_DEF_TRISTATE
+%token T_DEPENDS
+%token T_ENDCHOICE
+%token T_ENDIF
+%token T_ENDMENU
+%token T_HELP
+%token T_HEX
+%token T_IF
+%token T_IMPLY
+%token T_INT
+%token T_MAINMENU
+%token T_MENU
+%token T_MENUCONFIG
+%token T_MODULES
+%token T_ON
+%token T_OPEN_PAREN
+%token T_OPTIONAL
+%token T_PLUS_EQUAL
+%token T_PROMPT
+%token T_RANGE
+%token T_SELECT
+%token T_SOURCE
+%token T_STRING
+%token T_TRISTATE
+%token T_VISIBLE
+%token T_EOL
+%token <string> T_ASSIGN_VAL
+
+%left T_OR
+%left T_AND
+%left T_EQUAL T_UNEQUAL
+%left T_LESS T_LESS_EQUAL T_GREATER T_GREATER_EQUAL
+%nonassoc T_NOT
+
+%type <symbol> nonconst_symbol
+%type <symbol> symbol
+%type <type> type logic_type default
+%type <expr> expr
+%type <expr> if_expr
+%type <string> end
+%type <menu> if_entry menu_entry choice_entry
+%type <string> word_opt assign_val
+%type <flavor> assign_op
+
+%destructor {
+	fprintf(stderr, "%s:%d: missing end statement for this entry\n",
+		$$->file->name, $$->lineno);
+	if (current_menu == $$)
+		menu_end_menu();
+} if_entry menu_entry choice_entry
+
+%%
+input: mainmenu_stmt stmt_list | stmt_list;
+
+/* mainmenu entry */
+
+mainmenu_stmt: T_MAINMENU T_WORD_QUOTE T_EOL
+{
+	menu_add_prompt(P_MENU, $2, NULL);
+};
+
+stmt_list:
+	  /* empty */
+	| stmt_list assignment_stmt
+	| stmt_list choice_stmt
+	| stmt_list comment_stmt
+	| stmt_list config_stmt
+	| stmt_list if_stmt
+	| stmt_list menu_stmt
+	| stmt_list menuconfig_stmt
+	| stmt_list source_stmt
+	| stmt_list T_WORD error T_EOL	{ zconf_error("unknown statement \"%s\"", $2); }
+	| stmt_list error T_EOL		{ zconf_error("invalid statement"); }
+;
+
+stmt_list_in_choice:
+	  /* empty */
+	| stmt_list_in_choice comment_stmt
+	| stmt_list_in_choice config_stmt
+	| stmt_list_in_choice if_stmt_in_choice
+	| stmt_list_in_choice error T_EOL	{ zconf_error("invalid statement"); }
+;
+
+/* config/menuconfig entry */
+
+config_entry_start: T_CONFIG nonconst_symbol T_EOL
+{
+	$2->flags |= SYMBOL_OPTIONAL;
+	menu_add_entry($2);
+	printd(DEBUG_PARSE, "%s:%d:config %s\n", zconf_curname(), zconf_lineno(), $2->name);
+};
+
+config_stmt: config_entry_start config_option_list
+{
+	printd(DEBUG_PARSE, "%s:%d:endconfig\n", zconf_curname(), zconf_lineno());
+};
+
+menuconfig_entry_start: T_MENUCONFIG nonconst_symbol T_EOL
+{
+	$2->flags |= SYMBOL_OPTIONAL;
+	menu_add_entry($2);
+	printd(DEBUG_PARSE, "%s:%d:menuconfig %s\n", zconf_curname(), zconf_lineno(), $2->name);
+};
+
+menuconfig_stmt: menuconfig_entry_start config_option_list
+{
+	if (current_entry->prompt)
+		current_entry->prompt->type = P_MENU;
+	else
+		zconfprint("warning: menuconfig statement without prompt");
+	printd(DEBUG_PARSE, "%s:%d:endconfig\n", zconf_curname(), zconf_lineno());
+};
+
+config_option_list:
+	  /* empty */
+	| config_option_list config_option
+	| config_option_list depends
+	| config_option_list help
+;
+
+config_option: type prompt_stmt_opt T_EOL
+{
+	menu_set_type($1);
+	printd(DEBUG_PARSE, "%s:%d:type(%u)\n",
+		zconf_curname(), zconf_lineno(),
+		$1);
+};
+
+config_option: T_PROMPT T_WORD_QUOTE if_expr T_EOL
+{
+	menu_add_prompt(P_PROMPT, $2, $3);
+	printd(DEBUG_PARSE, "%s:%d:prompt\n", zconf_curname(), zconf_lineno());
+};
+
+config_option: default expr if_expr T_EOL
+{
+	menu_add_expr(P_DEFAULT, $2, $3);
+	if ($1 != S_UNKNOWN)
+		menu_set_type($1);
+	printd(DEBUG_PARSE, "%s:%d:default(%u)\n",
+		zconf_curname(), zconf_lineno(),
+		$1);
+};
+
+config_option: T_SELECT nonconst_symbol if_expr T_EOL
+{
+	menu_add_symbol(P_SELECT, $2, $3);
+	printd(DEBUG_PARSE, "%s:%d:select\n", zconf_curname(), zconf_lineno());
+};
+
+config_option: T_IMPLY nonconst_symbol if_expr T_EOL
+{
+	menu_add_symbol(P_IMPLY, $2, $3);
+	printd(DEBUG_PARSE, "%s:%d:imply\n", zconf_curname(), zconf_lineno());
+};
+
+config_option: T_RANGE symbol symbol if_expr T_EOL
+{
+	menu_add_expr(P_RANGE, expr_alloc_comp(E_RANGE,$2, $3), $4);
+	printd(DEBUG_PARSE, "%s:%d:range\n", zconf_curname(), zconf_lineno());
+};
+
+config_option: T_MODULES T_EOL
+{
+	if (modules_sym)
+		zconf_error("symbol '%s' redefines option 'modules' already defined by symbol '%s'",
+			    current_entry->sym->name, modules_sym->name);
+	modules_sym = current_entry->sym;
+};
+
+/* choice entry */
+
+choice: T_CHOICE word_opt T_EOL
+{
+	struct symbol *sym = sym_lookup($2, SYMBOL_CHOICE);
+	sym->flags |= SYMBOL_NO_WRITE;
+	menu_add_entry(sym);
+	menu_add_expr(P_CHOICE, NULL, NULL);
+	free($2);
+	printd(DEBUG_PARSE, "%s:%d:choice\n", zconf_curname(), zconf_lineno());
+};
+
+choice_entry: choice choice_option_list
+{
+	$$ = menu_add_menu();
+};
+
+choice_end: end
+{
+	if (zconf_endtoken($1, "choice")) {
+		menu_end_menu();
+		printd(DEBUG_PARSE, "%s:%d:endchoice\n", zconf_curname(), zconf_lineno());
+	}
+};
+
+choice_stmt: choice_entry stmt_list_in_choice choice_end
+;
+
+choice_option_list:
+	  /* empty */
+	| choice_option_list choice_option
+	| choice_option_list depends
+	| choice_option_list help
+;
+
+choice_option: T_PROMPT T_WORD_QUOTE if_expr T_EOL
+{
+	menu_add_prompt(P_PROMPT, $2, $3);
+	printd(DEBUG_PARSE, "%s:%d:prompt\n", zconf_curname(), zconf_lineno());
+};
+
+choice_option: logic_type prompt_stmt_opt T_EOL
+{
+	menu_set_type($1);
+	printd(DEBUG_PARSE, "%s:%d:type(%u)\n",
+	       zconf_curname(), zconf_lineno(), $1);
+};
+
+choice_option: T_OPTIONAL T_EOL
+{
+	current_entry->sym->flags |= SYMBOL_OPTIONAL;
+	printd(DEBUG_PARSE, "%s:%d:optional\n", zconf_curname(), zconf_lineno());
+};
+
+choice_option: T_DEFAULT nonconst_symbol if_expr T_EOL
+{
+	menu_add_symbol(P_DEFAULT, $2, $3);
+	printd(DEBUG_PARSE, "%s:%d:default\n",
+	       zconf_curname(), zconf_lineno());
+};
+
+type:
+	  logic_type
+	| T_INT			{ $$ = S_INT; }
+	| T_HEX			{ $$ = S_HEX; }
+	| T_STRING		{ $$ = S_STRING; }
+
+logic_type:
+	  T_BOOL		{ $$ = S_BOOLEAN; }
+	| T_TRISTATE		{ $$ = S_TRISTATE; }
+
+default:
+	  T_DEFAULT		{ $$ = S_UNKNOWN; }
+	| T_DEF_BOOL		{ $$ = S_BOOLEAN; }
+	| T_DEF_TRISTATE	{ $$ = S_TRISTATE; }
+
+/* if entry */
+
+if_entry: T_IF expr T_EOL
+{
+	printd(DEBUG_PARSE, "%s:%d:if\n", zconf_curname(), zconf_lineno());
+	menu_add_entry(NULL);
+	menu_add_dep($2);
+	$$ = menu_add_menu();
+};
+
+if_end: end
+{
+	if (zconf_endtoken($1, "if")) {
+		menu_end_menu();
+		printd(DEBUG_PARSE, "%s:%d:endif\n", zconf_curname(), zconf_lineno());
+	}
+};
+
+if_stmt: if_entry stmt_list if_end
+;
+
+if_stmt_in_choice: if_entry stmt_list_in_choice if_end
+;
+
+/* menu entry */
+
+menu: T_MENU T_WORD_QUOTE T_EOL
+{
+	menu_add_entry(NULL);
+	menu_add_prompt(P_MENU, $2, NULL);
+	printd(DEBUG_PARSE, "%s:%d:menu\n", zconf_curname(), zconf_lineno());
+};
+
+menu_entry: menu menu_option_list
+{
+	$$ = menu_add_menu();
+};
+
+menu_end: end
+{
+	if (zconf_endtoken($1, "menu")) {
+		menu_end_menu();
+		printd(DEBUG_PARSE, "%s:%d:endmenu\n", zconf_curname(), zconf_lineno());
+	}
+};
+
+menu_stmt: menu_entry stmt_list menu_end
+;
+
+menu_option_list:
+	  /* empty */
+	| menu_option_list visible
+	| menu_option_list depends
+;
+
+source_stmt: T_SOURCE T_WORD_QUOTE T_EOL
+{
+	printd(DEBUG_PARSE, "%s:%d:source %s\n", zconf_curname(), zconf_lineno(), $2);
+	zconf_nextfile($2);
+	free($2);
+};
+
+/* comment entry */
+
+comment: T_COMMENT T_WORD_QUOTE T_EOL
+{
+	menu_add_entry(NULL);
+	menu_add_prompt(P_COMMENT, $2, NULL);
+	printd(DEBUG_PARSE, "%s:%d:comment\n", zconf_curname(), zconf_lineno());
+};
+
+comment_stmt: comment comment_option_list
+;
+
+comment_option_list:
+	  /* empty */
+	| comment_option_list depends
+;
+
+/* help option */
+
+help_start: T_HELP T_EOL
+{
+	printd(DEBUG_PARSE, "%s:%d:help\n", zconf_curname(), zconf_lineno());
+	zconf_starthelp();
+};
+
+help: help_start T_HELPTEXT
+{
+	if (current_entry->help) {
+		free(current_entry->help);
+		zconfprint("warning: '%s' defined with more than one help text -- only the last one will be used",
+			   current_entry->sym->name ?: "<choice>");
+	}
+
+	/* Is the help text empty or all whitespace? */
+	if ($2[strspn($2, " \f\n\r\t\v")] == '\0')
+		zconfprint("warning: '%s' defined with blank help text",
+			   current_entry->sym->name ?: "<choice>");
+
+	current_entry->help = $2;
+};
+
+/* depends option */
+
+depends: T_DEPENDS T_ON expr T_EOL
+{
+	menu_add_dep($3);
+	printd(DEBUG_PARSE, "%s:%d:depends on\n", zconf_curname(), zconf_lineno());
+};
+
+/* visibility option */
+visible: T_VISIBLE if_expr T_EOL
+{
+	menu_add_visibility($2);
+};
+
+/* prompt statement */
+
+prompt_stmt_opt:
+	  /* empty */
+	| T_WORD_QUOTE if_expr
+{
+	menu_add_prompt(P_PROMPT, $1, $2);
+};
+
+end:	  T_ENDMENU T_EOL	{ $$ = "menu"; }
+	| T_ENDCHOICE T_EOL	{ $$ = "choice"; }
+	| T_ENDIF T_EOL		{ $$ = "if"; }
+;
+
+if_expr:  /* empty */			{ $$ = NULL; }
+	| T_IF expr			{ $$ = $2; }
+;
+
+expr:	  symbol				{ $$ = expr_alloc_symbol($1); }
+	| symbol T_LESS symbol			{ $$ = expr_alloc_comp(E_LTH, $1, $3); }
+	| symbol T_LESS_EQUAL symbol		{ $$ = expr_alloc_comp(E_LEQ, $1, $3); }
+	| symbol T_GREATER symbol		{ $$ = expr_alloc_comp(E_GTH, $1, $3); }
+	| symbol T_GREATER_EQUAL symbol		{ $$ = expr_alloc_comp(E_GEQ, $1, $3); }
+	| symbol T_EQUAL symbol			{ $$ = expr_alloc_comp(E_EQUAL, $1, $3); }
+	| symbol T_UNEQUAL symbol		{ $$ = expr_alloc_comp(E_UNEQUAL, $1, $3); }
+	| T_OPEN_PAREN expr T_CLOSE_PAREN	{ $$ = $2; }
+	| T_NOT expr				{ $$ = expr_alloc_one(E_NOT, $2); }
+	| expr T_OR expr			{ $$ = expr_alloc_two(E_OR, $1, $3); }
+	| expr T_AND expr			{ $$ = expr_alloc_two(E_AND, $1, $3); }
+;
+
+/* For symbol definitions, selects, etc., where quotes are not accepted */
+nonconst_symbol: T_WORD { $$ = sym_lookup($1, 0); free($1); };
+
+symbol:	  nonconst_symbol
+	| T_WORD_QUOTE	{ $$ = sym_lookup($1, SYMBOL_CONST); free($1); }
+;
+
+word_opt: /* empty */			{ $$ = NULL; }
+	| T_WORD
+
+/* assignment statement */
+
+assignment_stmt:  T_WORD assign_op assign_val T_EOL	{ variable_add($1, $3, $2); free($1); free($3); }
+
+assign_op:
+	  T_EQUAL	{ $$ = VAR_RECURSIVE; }
+	| T_COLON_EQUAL	{ $$ = VAR_SIMPLE; }
+	| T_PLUS_EQUAL	{ $$ = VAR_APPEND; }
+;
+
+assign_val:
+	/* empty */		{ $$ = xstrdup(""); };
+	| T_ASSIGN_VAL
+;
+
+%%
+
+void conf_parse(const char *name)
+{
+	struct symbol *sym;
+	int i;
+
+	zconf_initscan(name);
+
+	_menu_init();
+
+	if (getenv("ZCONF_DEBUG"))
+		yydebug = 1;
+	yyparse();
+
+	/* Variables are expanded in the parse phase. We can free them here. */
+	variable_all_del();
+
+	if (yynerrs)
+		exit(1);
+	if (!modules_sym)
+		modules_sym = sym_find( "n" );
+
+	if (!menu_has_prompt(&rootmenu)) {
+		current_entry = &rootmenu;
+		menu_add_prompt(P_MENU, "Main menu", NULL);
+	}
+
+	menu_finalize(&rootmenu);
+	for_all_symbols(i, sym) {
+		if (sym_check_deps(sym))
+			yynerrs++;
+	}
+	if (yynerrs)
+		exit(1);
+	conf_set_changed(true);
+}
+
+static bool zconf_endtoken(const char *tokenname,
+			   const char *expected_tokenname)
+{
+	if (strcmp(tokenname, expected_tokenname)) {
+		zconf_error("unexpected '%s' within %s block",
+			    tokenname, expected_tokenname);
+		yynerrs++;
+		return false;
+	}
+	if (current_menu->file != current_file) {
+		zconf_error("'%s' in different file than '%s'",
+			    tokenname, expected_tokenname);
+		fprintf(stderr, "%s:%d: location of the '%s'\n",
+			current_menu->file->name, current_menu->lineno,
+			expected_tokenname);
+		yynerrs++;
+		return false;
+	}
+	return true;
+}
+
+static void zconfprint(const char *err, ...)
+{
+	va_list ap;
+
+	fprintf(stderr, "%s:%d: ", zconf_curname(), zconf_lineno());
+	va_start(ap, err);
+	vfprintf(stderr, err, ap);
+	va_end(ap);
+	fprintf(stderr, "\n");
+}
+
+static void zconf_error(const char *err, ...)
+{
+	va_list ap;
+
+	yynerrs++;
+	fprintf(stderr, "%s:%d: ", zconf_curname(), zconf_lineno());
+	va_start(ap, err);
+	vfprintf(stderr, err, ap);
+	va_end(ap);
+	fprintf(stderr, "\n");
+}
+
+static void yyerror(const char *err)
+{
+	fprintf(stderr, "%s:%d: %s\n", zconf_curname(), zconf_lineno() + 1, err);
+}
+
+static void print_quoted_string(FILE *out, const char *str)
+{
+	const char *p;
+	int len;
+
+	putc('"', out);
+	while ((p = strchr(str, '"'))) {
+		len = p - str;
+		if (len)
+			fprintf(out, "%.*s", len, str);
+		fputs("\\\"", out);
+		str = p + 1;
+	}
+	fputs(str, out);
+	putc('"', out);
+}
+
+static void print_symbol(FILE *out, struct menu *menu)
+{
+	struct symbol *sym = menu->sym;
+	struct property *prop;
+
+	if (sym_is_choice(sym))
+		fprintf(out, "\nchoice\n");
+	else
+		fprintf(out, "\nconfig %s\n", sym->name);
+	switch (sym->type) {
+	case S_BOOLEAN:
+		fputs("  bool\n", out);
+		break;
+	case S_TRISTATE:
+		fputs("  tristate\n", out);
+		break;
+	case S_STRING:
+		fputs("  string\n", out);
+		break;
+	case S_INT:
+		fputs("  integer\n", out);
+		break;
+	case S_HEX:
+		fputs("  hex\n", out);
+		break;
+	default:
+		fputs("  ???\n", out);
+		break;
+	}
+	for (prop = sym->prop; prop; prop = prop->next) {
+		if (prop->menu != menu)
+			continue;
+		switch (prop->type) {
+		case P_PROMPT:
+			fputs("  prompt ", out);
+			print_quoted_string(out, prop->text);
+			if (!expr_is_yes(prop->visible.expr)) {
+				fputs(" if ", out);
+				expr_fprint(prop->visible.expr, out);
+			}
+			fputc('\n', out);
+			break;
+		case P_DEFAULT:
+			fputs( "  default ", out);
+			expr_fprint(prop->expr, out);
+			if (!expr_is_yes(prop->visible.expr)) {
+				fputs(" if ", out);
+				expr_fprint(prop->visible.expr, out);
+			}
+			fputc('\n', out);
+			break;
+		case P_CHOICE:
+			fputs("  #choice value\n", out);
+			break;
+		case P_SELECT:
+			fputs( "  select ", out);
+			expr_fprint(prop->expr, out);
+			fputc('\n', out);
+			break;
+		case P_IMPLY:
+			fputs( "  imply ", out);
+			expr_fprint(prop->expr, out);
+			fputc('\n', out);
+			break;
+		case P_RANGE:
+			fputs( "  range ", out);
+			expr_fprint(prop->expr, out);
+			fputc('\n', out);
+			break;
+		case P_MENU:
+			fputs( "  menu ", out);
+			print_quoted_string(out, prop->text);
+			fputc('\n', out);
+			break;
+		case P_SYMBOL:
+			fputs( "  symbol ", out);
+			fprintf(out, "%s\n", prop->menu->sym->name);
+			break;
+		default:
+			fprintf(out, "  unknown prop %d!\n", prop->type);
+			break;
+		}
+	}
+	if (menu->help) {
+		int len = strlen(menu->help);
+		while (menu->help[--len] == '\n')
+			menu->help[len] = 0;
+		fprintf(out, "  help\n%s\n", menu->help);
+	}
+}
+
+void zconfdump(FILE *out)
+{
+	struct property *prop;
+	struct symbol *sym;
+	struct menu *menu;
+
+	menu = rootmenu.list;
+	while (menu) {
+		if ((sym = menu->sym))
+			print_symbol(out, menu);
+		else if ((prop = menu->prompt)) {
+			switch (prop->type) {
+			case P_COMMENT:
+				fputs("\ncomment ", out);
+				print_quoted_string(out, prop->text);
+				fputs("\n", out);
+				break;
+			case P_MENU:
+				fputs("\nmenu ", out);
+				print_quoted_string(out, prop->text);
+				fputs("\n", out);
+				break;
+			default:
+				;
+			}
+			if (!expr_is_yes(prop->visible.expr)) {
+				fputs("  depends ", out);
+				expr_fprint(prop->visible.expr, out);
+				fputc('\n', out);
+			}
+		}
+
+		if (menu->list)
+			menu = menu->list;
+		else if (menu->next)
+			menu = menu->next;
+		else while ((menu = menu->parent)) {
+			if (menu->prompt && menu->prompt->type == P_MENU)
+				fputs("\nendmenu\n", out);
+			if (menu->next) {
+				menu = menu->next;
+				break;
+			}
+		}
+	}
+}
diff --git a/backport/kconf/preprocess.c b/backport/kconf/preprocess.c
new file mode 100644
index 000000000000..0590f86df6e4
--- /dev/null
+++ b/backport/kconf/preprocess.c
@@ -0,0 +1,574 @@
+// SPDX-License-Identifier: GPL-2.0
+//
+// Copyright (C) 2018 Masahiro Yamada <yamada.masahiro@socionext.com>
+
+#include <ctype.h>
+#include <stdarg.h>
+#include <stdbool.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+
+#include "list.h"
+#include "lkc.h"
+
+#define ARRAY_SIZE(arr)		(sizeof(arr) / sizeof((arr)[0]))
+
+static char *expand_string_with_args(const char *in, int argc, char *argv[]);
+static char *expand_string(const char *in);
+
+static void __attribute__((noreturn)) pperror(const char *format, ...)
+{
+	va_list ap;
+
+	fprintf(stderr, "%s:%d: ", current_file->name, yylineno);
+	va_start(ap, format);
+	vfprintf(stderr, format, ap);
+	va_end(ap);
+	fprintf(stderr, "\n");
+
+	exit(1);
+}
+
+/*
+ * Environment variables
+ */
+static LIST_HEAD(env_list);
+
+struct env {
+	char *name;
+	char *value;
+	struct list_head node;
+};
+
+static void env_add(const char *name, const char *value)
+{
+	struct env *e;
+
+	e = xmalloc(sizeof(*e));
+	e->name = xstrdup(name);
+	e->value = xstrdup(value);
+
+	list_add_tail(&e->node, &env_list);
+}
+
+static void env_del(struct env *e)
+{
+	list_del(&e->node);
+	free(e->name);
+	free(e->value);
+	free(e);
+}
+
+/* The returned pointer must be freed when done */
+static char *env_expand(const char *name)
+{
+	struct env *e;
+	const char *value;
+
+	if (!*name)
+		return NULL;
+
+	list_for_each_entry(e, &env_list, node) {
+		if (!strcmp(name, e->name))
+			return xstrdup(e->value);
+	}
+
+	value = getenv(name);
+	if (!value)
+		return NULL;
+
+	/*
+	 * We need to remember all referenced environment variables.
+	 * They will be written out to include/config/auto.conf.cmd
+	 */
+	env_add(name, value);
+
+	return xstrdup(value);
+}
+
+void env_write_dep(FILE *f, const char *autoconfig_name)
+{
+	struct env *e, *tmp;
+
+	list_for_each_entry_safe(e, tmp, &env_list, node) {
+		fprintf(f, "ifneq \"$(%s)\" \"%s\"\n", e->name, e->value);
+		fprintf(f, "%s: FORCE\n", autoconfig_name);
+		fprintf(f, "endif\n");
+		env_del(e);
+	}
+}
+
+/*
+ * Built-in functions
+ */
+struct function {
+	const char *name;
+	unsigned int min_args;
+	unsigned int max_args;
+	char *(*func)(int argc, char *argv[]);
+};
+
+static char *do_error_if(int argc, char *argv[])
+{
+	if (!strcmp(argv[0], "y"))
+		pperror("%s", argv[1]);
+
+	return xstrdup("");
+}
+
+static char *do_filename(int argc, char *argv[])
+{
+	return xstrdup(current_file->name);
+}
+
+static char *do_info(int argc, char *argv[])
+{
+	printf("%s\n", argv[0]);
+
+	return xstrdup("");
+}
+
+static char *do_lineno(int argc, char *argv[])
+{
+	char buf[16];
+
+	sprintf(buf, "%d", yylineno);
+
+	return xstrdup(buf);
+}
+
+static char *do_shell(int argc, char *argv[])
+{
+	FILE *p;
+	char buf[256];
+	char *cmd;
+	size_t nread;
+	int i;
+
+	cmd = argv[0];
+
+	p = popen(cmd, "r");
+	if (!p) {
+		perror(cmd);
+		exit(1);
+	}
+
+	nread = fread(buf, 1, sizeof(buf), p);
+	if (nread == sizeof(buf))
+		nread--;
+
+	/* remove trailing new lines */
+	while (nread > 0 && buf[nread - 1] == '\n')
+		nread--;
+
+	buf[nread] = 0;
+
+	/* replace a new line with a space */
+	for (i = 0; i < nread; i++) {
+		if (buf[i] == '\n')
+			buf[i] = ' ';
+	}
+
+	if (pclose(p) == -1) {
+		perror(cmd);
+		exit(1);
+	}
+
+	return xstrdup(buf);
+}
+
+static char *do_warning_if(int argc, char *argv[])
+{
+	if (!strcmp(argv[0], "y"))
+		fprintf(stderr, "%s:%d: %s\n",
+			current_file->name, yylineno, argv[1]);
+
+	return xstrdup("");
+}
+
+static const struct function function_table[] = {
+	/* Name		MIN	MAX	Function */
+	{ "error-if",	2,	2,	do_error_if },
+	{ "filename",	0,	0,	do_filename },
+	{ "info",	1,	1,	do_info },
+	{ "lineno",	0,	0,	do_lineno },
+	{ "shell",	1,	1,	do_shell },
+	{ "warning-if",	2,	2,	do_warning_if },
+};
+
+#define FUNCTION_MAX_ARGS		16
+
+static char *function_expand(const char *name, int argc, char *argv[])
+{
+	const struct function *f;
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(function_table); i++) {
+		f = &function_table[i];
+		if (strcmp(f->name, name))
+			continue;
+
+		if (argc < f->min_args)
+			pperror("too few function arguments passed to '%s'",
+				name);
+
+		if (argc > f->max_args)
+			pperror("too many function arguments passed to '%s'",
+				name);
+
+		return f->func(argc, argv);
+	}
+
+	return NULL;
+}
+
+/*
+ * Variables (and user-defined functions)
+ */
+static LIST_HEAD(variable_list);
+
+struct variable {
+	char *name;
+	char *value;
+	enum variable_flavor flavor;
+	int exp_count;
+	struct list_head node;
+};
+
+static struct variable *variable_lookup(const char *name)
+{
+	struct variable *v;
+
+	list_for_each_entry(v, &variable_list, node) {
+		if (!strcmp(name, v->name))
+			return v;
+	}
+
+	return NULL;
+}
+
+static char *variable_expand(const char *name, int argc, char *argv[])
+{
+	struct variable *v;
+	char *res;
+
+	v = variable_lookup(name);
+	if (!v)
+		return NULL;
+
+	if (argc == 0 && v->exp_count)
+		pperror("Recursive variable '%s' references itself (eventually)",
+			name);
+
+	if (v->exp_count > 1000)
+		pperror("Too deep recursive expansion");
+
+	v->exp_count++;
+
+	if (v->flavor == VAR_RECURSIVE)
+		res = expand_string_with_args(v->value, argc, argv);
+	else
+		res = xstrdup(v->value);
+
+	v->exp_count--;
+
+	return res;
+}
+
+void variable_add(const char *name, const char *value,
+		  enum variable_flavor flavor)
+{
+	struct variable *v;
+	char *new_value;
+	bool append = false;
+
+	v = variable_lookup(name);
+	if (v) {
+		/* For defined variables, += inherits the existing flavor */
+		if (flavor == VAR_APPEND) {
+			flavor = v->flavor;
+			append = true;
+		} else {
+			free(v->value);
+		}
+	} else {
+		/* For undefined variables, += assumes the recursive flavor */
+		if (flavor == VAR_APPEND)
+			flavor = VAR_RECURSIVE;
+
+		v = xmalloc(sizeof(*v));
+		v->name = xstrdup(name);
+		v->exp_count = 0;
+		list_add_tail(&v->node, &variable_list);
+	}
+
+	v->flavor = flavor;
+
+	if (flavor == VAR_SIMPLE)
+		new_value = expand_string(value);
+	else
+		new_value = xstrdup(value);
+
+	if (append) {
+		v->value = xrealloc(v->value,
+				    strlen(v->value) + strlen(new_value) + 2);
+		strcat(v->value, " ");
+		strcat(v->value, new_value);
+		free(new_value);
+	} else {
+		v->value = new_value;
+	}
+}
+
+static void variable_del(struct variable *v)
+{
+	list_del(&v->node);
+	free(v->name);
+	free(v->value);
+	free(v);
+}
+
+void variable_all_del(void)
+{
+	struct variable *v, *tmp;
+
+	list_for_each_entry_safe(v, tmp, &variable_list, node)
+		variable_del(v);
+}
+
+/*
+ * Evaluate a clause with arguments.  argc/argv are arguments from the upper
+ * function call.
+ *
+ * Returned string must be freed when done
+ */
+static char *eval_clause(const char *str, size_t len, int argc, char *argv[])
+{
+	char *tmp, *name, *res, *endptr, *prev, *p;
+	int new_argc = 0;
+	char *new_argv[FUNCTION_MAX_ARGS];
+	int nest = 0;
+	int i;
+	unsigned long n;
+
+	tmp = xstrndup(str, len);
+
+	/*
+	 * If variable name is '1', '2', etc.  It is generally an argument
+	 * from a user-function call (i.e. local-scope variable).  If not
+	 * available, then look-up global-scope variables.
+	 */
+	n = strtoul(tmp, &endptr, 10);
+	if (!*endptr && n > 0 && n <= argc) {
+		res = xstrdup(argv[n - 1]);
+		goto free_tmp;
+	}
+
+	prev = p = tmp;
+
+	/*
+	 * Split into tokens
+	 * The function name and arguments are separated by a comma.
+	 * For example, if the function call is like this:
+	 *   $(foo,$(x),$(y))
+	 *
+	 * The input string for this helper should be:
+	 *   foo,$(x),$(y)
+	 *
+	 * and split into:
+	 *   new_argv[0] = 'foo'
+	 *   new_argv[1] = '$(x)'
+	 *   new_argv[2] = '$(y)'
+	 */
+	while (*p) {
+		if (nest == 0 && *p == ',') {
+			*p = 0;
+			if (new_argc >= FUNCTION_MAX_ARGS)
+				pperror("too many function arguments");
+			new_argv[new_argc++] = prev;
+			prev = p + 1;
+		} else if (*p == '(') {
+			nest++;
+		} else if (*p == ')') {
+			nest--;
+		}
+
+		p++;
+	}
+	new_argv[new_argc++] = prev;
+
+	/*
+	 * Shift arguments
+	 * new_argv[0] represents a function name or a variable name.  Put it
+	 * into 'name', then shift the rest of the arguments.  This simplifies
+	 * 'const' handling.
+	 */
+	name = expand_string_with_args(new_argv[0], argc, argv);
+	new_argc--;
+	for (i = 0; i < new_argc; i++)
+		new_argv[i] = expand_string_with_args(new_argv[i + 1],
+						      argc, argv);
+
+	/* Search for variables */
+	res = variable_expand(name, new_argc, new_argv);
+	if (res)
+		goto free;
+
+	/* Look for built-in functions */
+	res = function_expand(name, new_argc, new_argv);
+	if (res)
+		goto free;
+
+	/* Last, try environment variable */
+	if (new_argc == 0) {
+		res = env_expand(name);
+		if (res)
+			goto free;
+	}
+
+	res = xstrdup("");
+free:
+	for (i = 0; i < new_argc; i++)
+		free(new_argv[i]);
+	free(name);
+free_tmp:
+	free(tmp);
+
+	return res;
+}
+
+/*
+ * Expand a string that follows '$'
+ *
+ * For example, if the input string is
+ *     ($(FOO)$($(BAR)))$(BAZ)
+ * this helper evaluates
+ *     $($(FOO)$($(BAR)))
+ * and returns a new string containing the expansion (note that the string is
+ * recursively expanded), also advancing 'str' to point to the next character
+ * after the corresponding closing parenthesis, in this case, *str will be
+ *     $(BAR)
+ */
+static char *expand_dollar_with_args(const char **str, int argc, char *argv[])
+{
+	const char *p = *str;
+	const char *q;
+	int nest = 0;
+
+	/*
+	 * In Kconfig, variable/function references always start with "$(".
+	 * Neither single-letter variables as in $A nor curly braces as in ${CC}
+	 * are supported.  '$' not followed by '(' loses its special meaning.
+	 */
+	if (*p != '(') {
+		*str = p;
+		return xstrdup("$");
+	}
+
+	p++;
+	q = p;
+	while (*q) {
+		if (*q == '(') {
+			nest++;
+		} else if (*q == ')') {
+			if (nest-- == 0)
+				break;
+		}
+		q++;
+	}
+
+	if (!*q)
+		pperror("unterminated reference to '%s': missing ')'", p);
+
+	/* Advance 'str' to after the expanded initial portion of the string */
+	*str = q + 1;
+
+	return eval_clause(p, q - p, argc, argv);
+}
+
+char *expand_dollar(const char **str)
+{
+	return expand_dollar_with_args(str, 0, NULL);
+}
+
+static char *__expand_string(const char **str, bool (*is_end)(char c),
+			     int argc, char *argv[])
+{
+	const char *in, *p;
+	char *expansion, *out;
+	size_t in_len, out_len;
+
+	out = xmalloc(1);
+	*out = 0;
+	out_len = 1;
+
+	p = in = *str;
+
+	while (1) {
+		if (*p == '$') {
+			in_len = p - in;
+			p++;
+			expansion = expand_dollar_with_args(&p, argc, argv);
+			out_len += in_len + strlen(expansion);
+			out = xrealloc(out, out_len);
+			strncat(out, in, in_len);
+			strcat(out, expansion);
+			free(expansion);
+			in = p;
+			continue;
+		}
+
+		if (is_end(*p))
+			break;
+
+		p++;
+	}
+
+	in_len = p - in;
+	out_len += in_len;
+	out = xrealloc(out, out_len);
+	strncat(out, in, in_len);
+
+	/* Advance 'str' to the end character */
+	*str = p;
+
+	return out;
+}
+
+static bool is_end_of_str(char c)
+{
+	return !c;
+}
+
+/*
+ * Expand variables and functions in the given string.  Undefined variables
+ * expand to an empty string.
+ * The returned string must be freed when done.
+ */
+static char *expand_string_with_args(const char *in, int argc, char *argv[])
+{
+	return __expand_string(&in, is_end_of_str, argc, argv);
+}
+
+static char *expand_string(const char *in)
+{
+	return expand_string_with_args(in, 0, NULL);
+}
+
+static bool is_end_of_token(char c)
+{
+	return !(isalnum(c) || c == '_' || c == '-');
+}
+
+/*
+ * Expand variables in a token.  The parsing stops when a token separater
+ * (in most cases, it is a whitespace) is encountered.  'str' is updated to
+ * point to the next character.
+ *
+ * The returned string must be freed when done.
+ */
+char *expand_one_token(const char **str)
+{
+	return __expand_string(str, is_end_of_token, 0, NULL);
+}
diff --git a/backport/kconf/setlocalversion b/backport/kconf/setlocalversion
new file mode 100755
index 000000000000..097b9423bc50
--- /dev/null
+++ b/backport/kconf/setlocalversion
@@ -0,0 +1,118 @@
+#!/bin/sh
+# SPDX-License-Identifier: GPL-2.0
+#
+# Copyright (c) 2005-2006 Ryan Anderson <ryan@michonline.com>
+# Copyright (c) 2006 Rene Scharfe <rene.scharfe@lsrfire.ath.cx>
+# Copyright (c) 2006 Uwe Zeisberger <zeisberg@informatik.uni-freiburg.de>
+# Copyright (c) 2007 Aron Griffis <aron@hp.com>
+# Copyright (c) 2007 Theodore Ts'o <tytso@mit.edu>
+# Copyright (c) 2008 Bryan Wu <bryan.wu@analog.com>
+# Copyright (c) 2008 Mike Frysinger <vapier@gentoo.org>
+# Copyright (c) 2008 Peter Korsgaard <jacmet@sunsite.dk>
+# Copyright (c) 2008 Sebastian Siewior <lkml@ml.breakpoint.cc>
+# Copyright (c) 2008 Trent Piepho <tpiepho@freescale.com>
+# Copyright (c) 2009 Mike Frysinger <vapier.adi@gmail.com>
+# Copyright (c) 2009 Nico Schottelius <nico-linuxsetlocalversion@schottelius.org>
+# Copyright (c) 2009 Peter Korsgaard <jacmet@sunsite.dk>
+# Copyright (c) 2010 Linus Torvalds <torvalds@linux-foundation.org>
+# Copyright (c) 2010 Michael Prokop <mika@grml.org>
+# Copyright (c) 2010 Michał Górny <gentoo@mgorny.alt.pl>
+# Copyright (c) 2010 Michal Marek <mmarek@suse.cz>
+# Copyright (c) 2010 Milton Miller <miltonm@bga.com>
+# Copyright (c) 2011 Mike Crowe <mcrowe@zipitwireless.com>
+# Copyright (c) 2012 Roland Dreier <roland@purestorage.com>
+# Copyright (c) 2013 Christian Kujau <lists@nerdbynature.de>
+# Copyright (c) 2013 Christophe Leroy <christophe.leroy@c-s.fr>
+# Copyright (c) 2013 Franck Bui-Huu <fbuihuu@gmail.com>
+# Copyright (c) 2015 Luis R. Rodriguez <mcgrof@do-not-panic.com>
+#
+# This file is released under the GPLv2.
+#
+# Taken from the Linux kernel as of v4.2-rc2 with a few modifications
+# described below.
+#
+# This scripts adds local version information from the version
+# control systems. It was taken from the Linux kernel as of v4.2-rc2
+# and simplified for use on Coccinelle by mcgrof. The version info
+# was hard coded to use long version. The svn postfix details were
+# also removed. I also added the option to enable this script to
+# work well for trees that do not use PGP signed tags or annotated
+# tags (git tag -s or git tag -a), git describe by default will only
+# look for these tags. If you do not use these you will want to set
+# the below variable to TAGS="--tags". If  you requires --tags, consider
+# to start signing your releases "git tag -s" and use a subkey for that.
+# If you do that, consider also using another PGP subkey for annotating
+# releases as deprecated.
+#
+# Set to emtpy variable if you use properly signed tags. You should do this!
+TAGS="--tags"
+
+srctree=.
+
+scm_version()
+{
+	local short
+	short=false
+
+
+	# Check for git and a git repo.
+	if test -z "$(git rev-parse --show-cdup 2>/dev/null)" &&
+	   head=`git rev-parse --verify --short HEAD 2>/dev/null`; then
+
+		# If we are at a tagged commit (like "v2.6.30-rc6"), we ignore
+		# it, because this version is defined in the top level Makefile.
+		if [ -z "`git describe $TAGS --exact-match 2>/dev/null`" ]; then
+
+			# If only the short version is requested, don't bother
+			# running further git commands
+			if $short; then
+				echo "+"
+				return
+			fi
+			# If we are past a tagged commit (like
+			# "v2.6.30-rc5-302-g72357d5"), we pretty print it.
+			if atag="`git describe $TAGS 2>/dev/null`"; then
+				echo "$atag" | awk -F- '{printf("-%05d-%s", $(NF-1),$(NF))}'
+
+			# If we don't have a tag at all we print -g{commitish}.
+			else
+				printf '%s%s' -g $head
+			fi
+		fi
+
+		# Check for uncommitted changes
+		if git diff-index --name-only HEAD | grep -qv "^scripts/package"; then
+			printf '%s' -dirty
+		fi
+
+		# All done with git
+		return
+	fi
+
+	# Check for mercurial and a mercurial repo.
+	if test -d .hg && hgid=`hg id 2>/dev/null`; then
+		# Do we have an tagged version?  If so, latesttagdistance == 1
+		if [ "`hg log -r . --template '{latesttagdistance}'`" == "1" ]; then
+			id=`hg log -r . --template '{latesttag}'`
+			printf '%s%s' -hg "$id"
+		else
+			tag=`printf '%s' "$hgid" | cut -d' ' -f2`
+			if [ -z "$tag" -o "$tag" = tip ]; then
+				id=`printf '%s' "$hgid" | sed 's/[+ ].*//'`
+				printf '%s%s' -hg "$id"
+			fi
+		fi
+
+		# Are there uncommitted changes?
+		# These are represented by + after the changeset id.
+		case "$hgid" in
+			*+|*+\ *) printf '%s' -dirty ;;
+		esac
+
+		# All done with mercurial
+		return
+	fi
+}
+
+res="$res$(scm_version)"
+echo "$res"
diff --git a/backport/kconf/symbol.c b/backport/kconf/symbol.c
new file mode 100644
index 000000000000..0572330bf8a7
--- /dev/null
+++ b/backport/kconf/symbol.c
@@ -0,0 +1,1270 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2002 Roman Zippel <zippel@linux-m68k.org>
+ */
+
+#include <sys/types.h>
+#include <ctype.h>
+#include <stdlib.h>
+#include <string.h>
+#include <regex.h>
+
+#include "lkc.h"
+
+struct symbol symbol_yes = {
+	.name = "y",
+	.curr = { "y", yes },
+	.flags = SYMBOL_CONST|SYMBOL_VALID,
+};
+
+struct symbol symbol_mod = {
+	.name = "m",
+	.curr = { "m", mod },
+	.flags = SYMBOL_CONST|SYMBOL_VALID,
+};
+
+struct symbol symbol_no = {
+	.name = "n",
+	.curr = { "n", no },
+	.flags = SYMBOL_CONST|SYMBOL_VALID,
+};
+
+static struct symbol symbol_empty = {
+	.name = "",
+	.curr = { "", no },
+	.flags = SYMBOL_VALID,
+};
+
+struct symbol *modules_sym;
+static tristate modules_val;
+
+enum symbol_type sym_get_type(struct symbol *sym)
+{
+	enum symbol_type type = sym->type;
+
+	if (type == S_TRISTATE) {
+		if (sym_is_choice_value(sym) && sym->visible == yes)
+			type = S_BOOLEAN;
+		else if (modules_val == no)
+			type = S_BOOLEAN;
+	}
+	return type;
+}
+
+const char *sym_type_name(enum symbol_type type)
+{
+	switch (type) {
+	case S_BOOLEAN:
+		return "bool";
+	case S_TRISTATE:
+		return "tristate";
+	case S_INT:
+		return "integer";
+	case S_HEX:
+		return "hex";
+	case S_STRING:
+		return "string";
+	case S_UNKNOWN:
+		return "unknown";
+	}
+	return "???";
+}
+
+struct property *sym_get_choice_prop(struct symbol *sym)
+{
+	struct property *prop;
+
+	for_all_choices(sym, prop)
+		return prop;
+	return NULL;
+}
+
+static struct property *sym_get_default_prop(struct symbol *sym)
+{
+	struct property *prop;
+
+	for_all_defaults(sym, prop) {
+		prop->visible.tri = expr_calc_value(prop->visible.expr);
+		if (prop->visible.tri != no)
+			return prop;
+	}
+	return NULL;
+}
+
+struct property *sym_get_range_prop(struct symbol *sym)
+{
+	struct property *prop;
+
+	for_all_properties(sym, prop, P_RANGE) {
+		prop->visible.tri = expr_calc_value(prop->visible.expr);
+		if (prop->visible.tri != no)
+			return prop;
+	}
+	return NULL;
+}
+
+static long long sym_get_range_val(struct symbol *sym, int base)
+{
+	sym_calc_value(sym);
+	switch (sym->type) {
+	case S_INT:
+		base = 10;
+		break;
+	case S_HEX:
+		base = 16;
+		break;
+	default:
+		break;
+	}
+	return strtoll(sym->curr.val, NULL, base);
+}
+
+static void sym_validate_range(struct symbol *sym)
+{
+	struct property *prop;
+	int base;
+	long long val, val2;
+	char str[64];
+
+	switch (sym->type) {
+	case S_INT:
+		base = 10;
+		break;
+	case S_HEX:
+		base = 16;
+		break;
+	default:
+		return;
+	}
+	prop = sym_get_range_prop(sym);
+	if (!prop)
+		return;
+	val = strtoll(sym->curr.val, NULL, base);
+	val2 = sym_get_range_val(prop->expr->left.sym, base);
+	if (val >= val2) {
+		val2 = sym_get_range_val(prop->expr->right.sym, base);
+		if (val <= val2)
+			return;
+	}
+	if (sym->type == S_INT)
+		sprintf(str, "%lld", val2);
+	else
+		sprintf(str, "0x%llx", val2);
+	sym->curr.val = xstrdup(str);
+}
+
+static void sym_set_changed(struct symbol *sym)
+{
+	struct property *prop;
+
+	sym->flags |= SYMBOL_CHANGED;
+	for (prop = sym->prop; prop; prop = prop->next) {
+		if (prop->menu)
+			prop->menu->flags |= MENU_CHANGED;
+	}
+}
+
+static void sym_set_all_changed(void)
+{
+	struct symbol *sym;
+	int i;
+
+	for_all_symbols(i, sym)
+		sym_set_changed(sym);
+}
+
+static void sym_calc_visibility(struct symbol *sym)
+{
+	struct property *prop;
+	struct symbol *choice_sym = NULL;
+	tristate tri;
+
+	/* any prompt visible? */
+	tri = no;
+
+	if (sym_is_choice_value(sym))
+		choice_sym = prop_get_symbol(sym_get_choice_prop(sym));
+
+	for_all_prompts(sym, prop) {
+		prop->visible.tri = expr_calc_value(prop->visible.expr);
+		/*
+		 * Tristate choice_values with visibility 'mod' are
+		 * not visible if the corresponding choice's value is
+		 * 'yes'.
+		 */
+		if (choice_sym && sym->type == S_TRISTATE &&
+		    prop->visible.tri == mod && choice_sym->curr.tri == yes)
+			prop->visible.tri = no;
+
+		tri = EXPR_OR(tri, prop->visible.tri);
+	}
+	if (tri == mod && (sym->type != S_TRISTATE || modules_val == no))
+		tri = yes;
+	if (sym->visible != tri) {
+		sym->visible = tri;
+		sym_set_changed(sym);
+	}
+	if (sym_is_choice_value(sym))
+		return;
+	/* defaulting to "yes" if no explicit "depends on" are given */
+	tri = yes;
+	if (sym->dir_dep.expr)
+		tri = expr_calc_value(sym->dir_dep.expr);
+	if (tri == mod && sym_get_type(sym) == S_BOOLEAN)
+		tri = yes;
+	if (sym->dir_dep.tri != tri) {
+		sym->dir_dep.tri = tri;
+		sym_set_changed(sym);
+	}
+	tri = no;
+	if (sym->rev_dep.expr)
+		tri = expr_calc_value(sym->rev_dep.expr);
+	if (tri == mod && sym_get_type(sym) == S_BOOLEAN)
+		tri = yes;
+	if (sym->rev_dep.tri != tri) {
+		sym->rev_dep.tri = tri;
+		sym_set_changed(sym);
+	}
+	tri = no;
+	if (sym->implied.expr)
+		tri = expr_calc_value(sym->implied.expr);
+	if (tri == mod && sym_get_type(sym) == S_BOOLEAN)
+		tri = yes;
+	if (sym->implied.tri != tri) {
+		sym->implied.tri = tri;
+		sym_set_changed(sym);
+	}
+}
+
+/*
+ * Find the default symbol for a choice.
+ * First try the default values for the choice symbol
+ * Next locate the first visible choice value
+ * Return NULL if none was found
+ */
+struct symbol *sym_choice_default(struct symbol *sym)
+{
+	struct symbol *def_sym;
+	struct property *prop;
+	struct expr *e;
+
+	/* any of the defaults visible? */
+	for_all_defaults(sym, prop) {
+		prop->visible.tri = expr_calc_value(prop->visible.expr);
+		if (prop->visible.tri == no)
+			continue;
+		def_sym = prop_get_symbol(prop);
+		if (def_sym->visible != no)
+			return def_sym;
+	}
+
+	/* just get the first visible value */
+	prop = sym_get_choice_prop(sym);
+	expr_list_for_each_sym(prop->expr, e, def_sym)
+		if (def_sym->visible != no)
+			return def_sym;
+
+	/* failed to locate any defaults */
+	return NULL;
+}
+
+static struct symbol *sym_calc_choice(struct symbol *sym)
+{
+	struct symbol *def_sym;
+	struct property *prop;
+	struct expr *e;
+	int flags;
+
+	/* first calculate all choice values' visibilities */
+	flags = sym->flags;
+	prop = sym_get_choice_prop(sym);
+	expr_list_for_each_sym(prop->expr, e, def_sym) {
+		sym_calc_visibility(def_sym);
+		if (def_sym->visible != no)
+			flags &= def_sym->flags;
+	}
+
+	sym->flags &= flags | ~SYMBOL_DEF_USER;
+
+	/* is the user choice visible? */
+	def_sym = sym->def[S_DEF_USER].val;
+	if (def_sym && def_sym->visible != no)
+		return def_sym;
+
+	def_sym = sym_choice_default(sym);
+
+	if (def_sym == NULL)
+		/* no choice? reset tristate value */
+		sym->curr.tri = no;
+
+	return def_sym;
+}
+
+static void sym_warn_unmet_dep(struct symbol *sym)
+{
+	struct gstr gs = str_new();
+
+	str_printf(&gs,
+		   "\nWARNING: unmet direct dependencies detected for %s\n",
+		   sym->name);
+	str_printf(&gs,
+		   "  Depends on [%c]: ",
+		   sym->dir_dep.tri == mod ? 'm' : 'n');
+	expr_gstr_print(sym->dir_dep.expr, &gs);
+	str_printf(&gs, "\n");
+
+	expr_gstr_print_revdep(sym->rev_dep.expr, &gs, yes,
+			       "  Selected by [y]:\n");
+	expr_gstr_print_revdep(sym->rev_dep.expr, &gs, mod,
+			       "  Selected by [m]:\n");
+
+	fputs(str_get(&gs), stderr);
+}
+
+void sym_calc_value(struct symbol *sym)
+{
+	struct symbol_value newval, oldval;
+	struct property *prop;
+	struct expr *e;
+
+	if (!sym)
+		return;
+
+	if (sym->flags & SYMBOL_VALID)
+		return;
+
+	if (sym_is_choice_value(sym) &&
+	    sym->flags & SYMBOL_NEED_SET_CHOICE_VALUES) {
+		sym->flags &= ~SYMBOL_NEED_SET_CHOICE_VALUES;
+		prop = sym_get_choice_prop(sym);
+		sym_calc_value(prop_get_symbol(prop));
+	}
+
+	sym->flags |= SYMBOL_VALID;
+
+	oldval = sym->curr;
+
+	switch (sym->type) {
+	case S_INT:
+	case S_HEX:
+	case S_STRING:
+		newval = symbol_empty.curr;
+		break;
+	case S_BOOLEAN:
+	case S_TRISTATE:
+		newval = symbol_no.curr;
+		break;
+	default:
+		sym->curr.val = sym->name;
+		sym->curr.tri = no;
+		return;
+	}
+	sym->flags &= ~SYMBOL_WRITE;
+
+	sym_calc_visibility(sym);
+
+	if (sym->visible != no)
+		sym->flags |= SYMBOL_WRITE;
+
+	/* set default if recursively called */
+	sym->curr = newval;
+
+	switch (sym_get_type(sym)) {
+	case S_BOOLEAN:
+	case S_TRISTATE:
+		if (sym_is_choice_value(sym) && sym->visible == yes) {
+			prop = sym_get_choice_prop(sym);
+			newval.tri = (prop_get_symbol(prop)->curr.val == sym) ? yes : no;
+		} else {
+			if (sym->visible != no) {
+				/* if the symbol is visible use the user value
+				 * if available, otherwise try the default value
+				 */
+				if (sym_has_value(sym)) {
+					newval.tri = EXPR_AND(sym->def[S_DEF_USER].tri,
+							      sym->visible);
+					goto calc_newval;
+				}
+			}
+			if (sym->rev_dep.tri != no)
+				sym->flags |= SYMBOL_WRITE;
+			if (!sym_is_choice(sym)) {
+				prop = sym_get_default_prop(sym);
+				if (prop) {
+					newval.tri = EXPR_AND(expr_calc_value(prop->expr),
+							      prop->visible.tri);
+					if (newval.tri != no)
+						sym->flags |= SYMBOL_WRITE;
+				}
+				if (sym->implied.tri != no) {
+					sym->flags |= SYMBOL_WRITE;
+					newval.tri = EXPR_OR(newval.tri, sym->implied.tri);
+					newval.tri = EXPR_AND(newval.tri,
+							      sym->dir_dep.tri);
+				}
+			}
+		calc_newval:
+			if (sym->dir_dep.tri < sym->rev_dep.tri)
+				sym_warn_unmet_dep(sym);
+			newval.tri = EXPR_OR(newval.tri, sym->rev_dep.tri);
+		}
+		if (newval.tri == mod && sym_get_type(sym) == S_BOOLEAN)
+			newval.tri = yes;
+		break;
+	case S_STRING:
+	case S_HEX:
+	case S_INT:
+		if (sym->visible != no && sym_has_value(sym)) {
+			newval.val = sym->def[S_DEF_USER].val;
+			break;
+		}
+		prop = sym_get_default_prop(sym);
+		if (prop) {
+			struct symbol *ds = prop_get_symbol(prop);
+			if (ds) {
+				sym->flags |= SYMBOL_WRITE;
+				sym_calc_value(ds);
+				newval.val = ds->curr.val;
+			}
+		}
+		break;
+	default:
+		;
+	}
+
+	sym->curr = newval;
+	if (sym_is_choice(sym) && newval.tri == yes)
+		sym->curr.val = sym_calc_choice(sym);
+	sym_validate_range(sym);
+
+	if (memcmp(&oldval, &sym->curr, sizeof(oldval))) {
+		sym_set_changed(sym);
+		if (modules_sym == sym) {
+			sym_set_all_changed();
+			modules_val = modules_sym->curr.tri;
+		}
+	}
+
+	if (sym_is_choice(sym)) {
+		struct symbol *choice_sym;
+
+		prop = sym_get_choice_prop(sym);
+		expr_list_for_each_sym(prop->expr, e, choice_sym) {
+			if ((sym->flags & SYMBOL_WRITE) &&
+			    choice_sym->visible != no)
+				choice_sym->flags |= SYMBOL_WRITE;
+			if (sym->flags & SYMBOL_CHANGED)
+				sym_set_changed(choice_sym);
+		}
+	}
+
+	if (sym->flags & SYMBOL_NO_WRITE)
+		sym->flags &= ~SYMBOL_WRITE;
+
+	if (sym->flags & SYMBOL_NEED_SET_CHOICE_VALUES)
+		set_all_choice_values(sym);
+}
+
+void sym_clear_all_valid(void)
+{
+	struct symbol *sym;
+	int i;
+
+	for_all_symbols(i, sym)
+		sym->flags &= ~SYMBOL_VALID;
+	conf_set_changed(true);
+	sym_calc_value(modules_sym);
+}
+
+bool sym_tristate_within_range(struct symbol *sym, tristate val)
+{
+	int type = sym_get_type(sym);
+
+	if (sym->visible == no)
+		return false;
+
+	if (type != S_BOOLEAN && type != S_TRISTATE)
+		return false;
+
+	if (type == S_BOOLEAN && val == mod)
+		return false;
+	if (sym->visible <= sym->rev_dep.tri)
+		return false;
+	if (sym_is_choice_value(sym) && sym->visible == yes)
+		return val == yes;
+	return val >= sym->rev_dep.tri && val <= sym->visible;
+}
+
+bool sym_set_tristate_value(struct symbol *sym, tristate val)
+{
+	tristate oldval = sym_get_tristate_value(sym);
+
+	if (oldval != val && !sym_tristate_within_range(sym, val))
+		return false;
+
+	if (!(sym->flags & SYMBOL_DEF_USER)) {
+		sym->flags |= SYMBOL_DEF_USER;
+		sym_set_changed(sym);
+	}
+	/*
+	 * setting a choice value also resets the new flag of the choice
+	 * symbol and all other choice values.
+	 */
+	if (sym_is_choice_value(sym) && val == yes) {
+		struct symbol *cs = prop_get_symbol(sym_get_choice_prop(sym));
+		struct property *prop;
+		struct expr *e;
+
+		cs->def[S_DEF_USER].val = sym;
+		cs->flags |= SYMBOL_DEF_USER;
+		prop = sym_get_choice_prop(cs);
+		for (e = prop->expr; e; e = e->left.expr) {
+			if (e->right.sym->visible != no)
+				e->right.sym->flags |= SYMBOL_DEF_USER;
+		}
+	}
+
+	sym->def[S_DEF_USER].tri = val;
+	if (oldval != val)
+		sym_clear_all_valid();
+
+	return true;
+}
+
+tristate sym_toggle_tristate_value(struct symbol *sym)
+{
+	tristate oldval, newval;
+
+	oldval = newval = sym_get_tristate_value(sym);
+	do {
+		switch (newval) {
+		case no:
+			newval = mod;
+			break;
+		case mod:
+			newval = yes;
+			break;
+		case yes:
+			newval = no;
+			break;
+		}
+		if (sym_set_tristate_value(sym, newval))
+			break;
+	} while (oldval != newval);
+	return newval;
+}
+
+bool sym_string_valid(struct symbol *sym, const char *str)
+{
+	signed char ch;
+
+	switch (sym->type) {
+	case S_STRING:
+		return true;
+	case S_INT:
+		ch = *str++;
+		if (ch == '-')
+			ch = *str++;
+		if (!isdigit(ch))
+			return false;
+		if (ch == '0' && *str != 0)
+			return false;
+		while ((ch = *str++)) {
+			if (!isdigit(ch))
+				return false;
+		}
+		return true;
+	case S_HEX:
+		if (str[0] == '0' && (str[1] == 'x' || str[1] == 'X'))
+			str += 2;
+		ch = *str++;
+		do {
+			if (!isxdigit(ch))
+				return false;
+		} while ((ch = *str++));
+		return true;
+	case S_BOOLEAN:
+	case S_TRISTATE:
+		switch (str[0]) {
+		case 'y': case 'Y':
+		case 'm': case 'M':
+		case 'n': case 'N':
+			return true;
+		}
+		return false;
+	default:
+		return false;
+	}
+}
+
+bool sym_string_within_range(struct symbol *sym, const char *str)
+{
+	struct property *prop;
+	long long val;
+
+	switch (sym->type) {
+	case S_STRING:
+		return sym_string_valid(sym, str);
+	case S_INT:
+		if (!sym_string_valid(sym, str))
+			return false;
+		prop = sym_get_range_prop(sym);
+		if (!prop)
+			return true;
+		val = strtoll(str, NULL, 10);
+		return val >= sym_get_range_val(prop->expr->left.sym, 10) &&
+		       val <= sym_get_range_val(prop->expr->right.sym, 10);
+	case S_HEX:
+		if (!sym_string_valid(sym, str))
+			return false;
+		prop = sym_get_range_prop(sym);
+		if (!prop)
+			return true;
+		val = strtoll(str, NULL, 16);
+		return val >= sym_get_range_val(prop->expr->left.sym, 16) &&
+		       val <= sym_get_range_val(prop->expr->right.sym, 16);
+	case S_BOOLEAN:
+	case S_TRISTATE:
+		switch (str[0]) {
+		case 'y': case 'Y':
+			return sym_tristate_within_range(sym, yes);
+		case 'm': case 'M':
+			return sym_tristate_within_range(sym, mod);
+		case 'n': case 'N':
+			return sym_tristate_within_range(sym, no);
+		}
+		return false;
+	default:
+		return false;
+	}
+}
+
+bool sym_set_string_value(struct symbol *sym, const char *newval)
+{
+	const char *oldval;
+	char *val;
+	int size;
+
+	switch (sym->type) {
+	case S_BOOLEAN:
+	case S_TRISTATE:
+		switch (newval[0]) {
+		case 'y': case 'Y':
+			return sym_set_tristate_value(sym, yes);
+		case 'm': case 'M':
+			return sym_set_tristate_value(sym, mod);
+		case 'n': case 'N':
+			return sym_set_tristate_value(sym, no);
+		}
+		return false;
+	default:
+		;
+	}
+
+	if (!sym_string_within_range(sym, newval))
+		return false;
+
+	if (!(sym->flags & SYMBOL_DEF_USER)) {
+		sym->flags |= SYMBOL_DEF_USER;
+		sym_set_changed(sym);
+	}
+
+	oldval = sym->def[S_DEF_USER].val;
+	size = strlen(newval) + 1;
+	if (sym->type == S_HEX && (newval[0] != '0' || (newval[1] != 'x' && newval[1] != 'X'))) {
+		size += 2;
+		sym->def[S_DEF_USER].val = val = xmalloc(size);
+		*val++ = '0';
+		*val++ = 'x';
+	} else if (!oldval || strcmp(oldval, newval))
+		sym->def[S_DEF_USER].val = val = xmalloc(size);
+	else
+		return true;
+
+	strcpy(val, newval);
+	free((void *)oldval);
+	sym_clear_all_valid();
+
+	return true;
+}
+
+/*
+ * Find the default value associated to a symbol.
+ * For tristate symbol handle the modules=n case
+ * in which case "m" becomes "y".
+ * If the symbol does not have any default then fallback
+ * to the fixed default values.
+ */
+const char *sym_get_string_default(struct symbol *sym)
+{
+	struct property *prop;
+	struct symbol *ds;
+	const char *str;
+	tristate val;
+
+	sym_calc_visibility(sym);
+	sym_calc_value(modules_sym);
+	val = symbol_no.curr.tri;
+	str = symbol_empty.curr.val;
+
+	/* If symbol has a default value look it up */
+	prop = sym_get_default_prop(sym);
+	if (prop != NULL) {
+		switch (sym->type) {
+		case S_BOOLEAN:
+		case S_TRISTATE:
+			/* The visibility may limit the value from yes => mod */
+			val = EXPR_AND(expr_calc_value(prop->expr), prop->visible.tri);
+			break;
+		default:
+			/*
+			 * The following fails to handle the situation
+			 * where a default value is further limited by
+			 * the valid range.
+			 */
+			ds = prop_get_symbol(prop);
+			if (ds != NULL) {
+				sym_calc_value(ds);
+				str = (const char *)ds->curr.val;
+			}
+		}
+	}
+
+	/* Handle select statements */
+	val = EXPR_OR(val, sym->rev_dep.tri);
+
+	/* transpose mod to yes if modules are not enabled */
+	if (val == mod)
+		if (!sym_is_choice_value(sym) && modules_sym->curr.tri == no)
+			val = yes;
+
+	/* transpose mod to yes if type is bool */
+	if (sym->type == S_BOOLEAN && val == mod)
+		val = yes;
+
+	/* adjust the default value if this symbol is implied by another */
+	if (val < sym->implied.tri)
+		val = sym->implied.tri;
+
+	switch (sym->type) {
+	case S_BOOLEAN:
+	case S_TRISTATE:
+		switch (val) {
+		case no: return "n";
+		case mod: return "m";
+		case yes: return "y";
+		}
+	case S_INT:
+	case S_HEX:
+		return str;
+	case S_STRING:
+		return str;
+	case S_UNKNOWN:
+		break;
+	}
+	return "";
+}
+
+const char *sym_get_string_value(struct symbol *sym)
+{
+	tristate val;
+
+	switch (sym->type) {
+	case S_BOOLEAN:
+	case S_TRISTATE:
+		val = sym_get_tristate_value(sym);
+		switch (val) {
+		case no:
+			return "n";
+		case mod:
+			sym_calc_value(modules_sym);
+			return (modules_sym->curr.tri == no) ? "n" : "m";
+		case yes:
+			return "y";
+		}
+		break;
+	default:
+		;
+	}
+	return (const char *)sym->curr.val;
+}
+
+bool sym_is_changeable(struct symbol *sym)
+{
+	return sym->visible > sym->rev_dep.tri;
+}
+
+static unsigned strhash(const char *s)
+{
+	/* fnv32 hash */
+	unsigned hash = 2166136261U;
+	for (; *s; s++)
+		hash = (hash ^ *s) * 0x01000193;
+	return hash;
+}
+
+struct symbol *sym_lookup(const char *name, int flags)
+{
+	struct symbol *symbol;
+	char *new_name;
+	int hash;
+
+	if (name) {
+		if (name[0] && !name[1]) {
+			switch (name[0]) {
+			case 'y': return &symbol_yes;
+			case 'm': return &symbol_mod;
+			case 'n': return &symbol_no;
+			}
+		}
+		hash = strhash(name) % SYMBOL_HASHSIZE;
+
+		for (symbol = symbol_hash[hash]; symbol; symbol = symbol->next) {
+			if (symbol->name &&
+			    !strcmp(symbol->name, name) &&
+			    (flags ? symbol->flags & flags
+				   : !(symbol->flags & (SYMBOL_CONST|SYMBOL_CHOICE))))
+				return symbol;
+		}
+		new_name = xstrdup(name);
+	} else {
+		new_name = NULL;
+		hash = 0;
+	}
+
+	symbol = xmalloc(sizeof(*symbol));
+	memset(symbol, 0, sizeof(*symbol));
+	symbol->name = new_name;
+	symbol->type = S_UNKNOWN;
+	symbol->flags = flags;
+
+	symbol->next = symbol_hash[hash];
+	symbol_hash[hash] = symbol;
+
+	return symbol;
+}
+
+struct symbol *sym_find(const char *name)
+{
+	struct symbol *symbol = NULL;
+	int hash = 0;
+
+	if (!name)
+		return NULL;
+
+	if (name[0] && !name[1]) {
+		switch (name[0]) {
+		case 'y': return &symbol_yes;
+		case 'm': return &symbol_mod;
+		case 'n': return &symbol_no;
+		}
+	}
+	hash = strhash(name) % SYMBOL_HASHSIZE;
+
+	for (symbol = symbol_hash[hash]; symbol; symbol = symbol->next) {
+		if (symbol->name &&
+		    !strcmp(symbol->name, name) &&
+		    !(symbol->flags & SYMBOL_CONST))
+				break;
+	}
+
+	return symbol;
+}
+
+struct sym_match {
+	struct symbol	*sym;
+	off_t		so, eo;
+};
+
+/* Compare matched symbols as thus:
+ * - first, symbols that match exactly
+ * - then, alphabetical sort
+ */
+static int sym_rel_comp(const void *sym1, const void *sym2)
+{
+	const struct sym_match *s1 = sym1;
+	const struct sym_match *s2 = sym2;
+	int exact1, exact2;
+
+	/* Exact match:
+	 * - if matched length on symbol s1 is the length of that symbol,
+	 *   then this symbol should come first;
+	 * - if matched length on symbol s2 is the length of that symbol,
+	 *   then this symbol should come first.
+	 * Note: since the search can be a regexp, both symbols may match
+	 * exactly; if this is the case, we can't decide which comes first,
+	 * and we fallback to sorting alphabetically.
+	 */
+	exact1 = (s1->eo - s1->so) == strlen(s1->sym->name);
+	exact2 = (s2->eo - s2->so) == strlen(s2->sym->name);
+	if (exact1 && !exact2)
+		return -1;
+	if (!exact1 && exact2)
+		return 1;
+
+	/* As a fallback, sort symbols alphabetically */
+	return strcmp(s1->sym->name, s2->sym->name);
+}
+
+struct symbol **sym_re_search(const char *pattern)
+{
+	struct symbol *sym, **sym_arr = NULL;
+	struct sym_match *sym_match_arr = NULL;
+	int i, cnt, size;
+	regex_t re;
+	regmatch_t match[1];
+
+	cnt = size = 0;
+	/* Skip if empty */
+	if (strlen(pattern) == 0)
+		return NULL;
+	if (regcomp(&re, pattern, REG_EXTENDED|REG_ICASE))
+		return NULL;
+
+	for_all_symbols(i, sym) {
+		if (sym->flags & SYMBOL_CONST || !sym->name)
+			continue;
+		if (regexec(&re, sym->name, 1, match, 0))
+			continue;
+		if (cnt >= size) {
+			void *tmp;
+			size += 16;
+			tmp = realloc(sym_match_arr, size * sizeof(struct sym_match));
+			if (!tmp)
+				goto sym_re_search_free;
+			sym_match_arr = tmp;
+		}
+		sym_calc_value(sym);
+		/* As regexec returned 0, we know we have a match, so
+		 * we can use match[0].rm_[se]o without further checks
+		 */
+		sym_match_arr[cnt].so = match[0].rm_so;
+		sym_match_arr[cnt].eo = match[0].rm_eo;
+		sym_match_arr[cnt++].sym = sym;
+	}
+	if (sym_match_arr) {
+		qsort(sym_match_arr, cnt, sizeof(struct sym_match), sym_rel_comp);
+		sym_arr = malloc((cnt+1) * sizeof(struct symbol *));
+		if (!sym_arr)
+			goto sym_re_search_free;
+		for (i = 0; i < cnt; i++)
+			sym_arr[i] = sym_match_arr[i].sym;
+		sym_arr[cnt] = NULL;
+	}
+sym_re_search_free:
+	/* sym_match_arr can be NULL if no match, but free(NULL) is OK */
+	free(sym_match_arr);
+	regfree(&re);
+
+	return sym_arr;
+}
+
+/*
+ * When we check for recursive dependencies we use a stack to save
+ * current state so we can print out relevant info to user.
+ * The entries are located on the call stack so no need to free memory.
+ * Note insert() remove() must always match to properly clear the stack.
+ */
+static struct dep_stack {
+	struct dep_stack *prev, *next;
+	struct symbol *sym;
+	struct property *prop;
+	struct expr **expr;
+} *check_top;
+
+static void dep_stack_insert(struct dep_stack *stack, struct symbol *sym)
+{
+	memset(stack, 0, sizeof(*stack));
+	if (check_top)
+		check_top->next = stack;
+	stack->prev = check_top;
+	stack->sym = sym;
+	check_top = stack;
+}
+
+static void dep_stack_remove(void)
+{
+	check_top = check_top->prev;
+	if (check_top)
+		check_top->next = NULL;
+}
+
+/*
+ * Called when we have detected a recursive dependency.
+ * check_top point to the top of the stact so we use
+ * the ->prev pointer to locate the bottom of the stack.
+ */
+static void sym_check_print_recursive(struct symbol *last_sym)
+{
+	struct dep_stack *stack;
+	struct symbol *sym, *next_sym;
+	struct menu *menu = NULL;
+	struct property *prop;
+	struct dep_stack cv_stack;
+
+	if (sym_is_choice_value(last_sym)) {
+		dep_stack_insert(&cv_stack, last_sym);
+		last_sym = prop_get_symbol(sym_get_choice_prop(last_sym));
+	}
+
+	for (stack = check_top; stack != NULL; stack = stack->prev)
+		if (stack->sym == last_sym)
+			break;
+	if (!stack) {
+		fprintf(stderr, "unexpected recursive dependency error\n");
+		return;
+	}
+
+	for (; stack; stack = stack->next) {
+		sym = stack->sym;
+		next_sym = stack->next ? stack->next->sym : last_sym;
+		prop = stack->prop;
+		if (prop == NULL)
+			prop = stack->sym->prop;
+
+		/* for choice values find the menu entry (used below) */
+		if (sym_is_choice(sym) || sym_is_choice_value(sym)) {
+			for (prop = sym->prop; prop; prop = prop->next) {
+				menu = prop->menu;
+				if (prop->menu)
+					break;
+			}
+		}
+		if (stack->sym == last_sym)
+			fprintf(stderr, "%s:%d:error: recursive dependency detected!\n",
+				prop->file->name, prop->lineno);
+
+		if (sym_is_choice(sym)) {
+			fprintf(stderr, "%s:%d:\tchoice %s contains symbol %s\n",
+				menu->file->name, menu->lineno,
+				sym->name ? sym->name : "<choice>",
+				next_sym->name ? next_sym->name : "<choice>");
+		} else if (sym_is_choice_value(sym)) {
+			fprintf(stderr, "%s:%d:\tsymbol %s is part of choice %s\n",
+				menu->file->name, menu->lineno,
+				sym->name ? sym->name : "<choice>",
+				next_sym->name ? next_sym->name : "<choice>");
+		} else if (stack->expr == &sym->dir_dep.expr) {
+			fprintf(stderr, "%s:%d:\tsymbol %s depends on %s\n",
+				prop->file->name, prop->lineno,
+				sym->name ? sym->name : "<choice>",
+				next_sym->name ? next_sym->name : "<choice>");
+		} else if (stack->expr == &sym->rev_dep.expr) {
+			fprintf(stderr, "%s:%d:\tsymbol %s is selected by %s\n",
+				prop->file->name, prop->lineno,
+				sym->name ? sym->name : "<choice>",
+				next_sym->name ? next_sym->name : "<choice>");
+		} else if (stack->expr == &sym->implied.expr) {
+			fprintf(stderr, "%s:%d:\tsymbol %s is implied by %s\n",
+				prop->file->name, prop->lineno,
+				sym->name ? sym->name : "<choice>",
+				next_sym->name ? next_sym->name : "<choice>");
+		} else if (stack->expr) {
+			fprintf(stderr, "%s:%d:\tsymbol %s %s value contains %s\n",
+				prop->file->name, prop->lineno,
+				sym->name ? sym->name : "<choice>",
+				prop_get_type_name(prop->type),
+				next_sym->name ? next_sym->name : "<choice>");
+		} else {
+			fprintf(stderr, "%s:%d:\tsymbol %s %s is visible depending on %s\n",
+				prop->file->name, prop->lineno,
+				sym->name ? sym->name : "<choice>",
+				prop_get_type_name(prop->type),
+				next_sym->name ? next_sym->name : "<choice>");
+		}
+	}
+
+	fprintf(stderr,
+		"For a resolution refer to Documentation/kbuild/kconfig-language.rst\n"
+		"subsection \"Kconfig recursive dependency limitations\"\n"
+		"\n");
+
+	if (check_top == &cv_stack)
+		dep_stack_remove();
+}
+
+static struct symbol *sym_check_expr_deps(struct expr *e)
+{
+	struct symbol *sym;
+
+	if (!e)
+		return NULL;
+	switch (e->type) {
+	case E_OR:
+	case E_AND:
+		sym = sym_check_expr_deps(e->left.expr);
+		if (sym)
+			return sym;
+		return sym_check_expr_deps(e->right.expr);
+	case E_NOT:
+		return sym_check_expr_deps(e->left.expr);
+	case E_EQUAL:
+	case E_GEQ:
+	case E_GTH:
+	case E_LEQ:
+	case E_LTH:
+	case E_UNEQUAL:
+		sym = sym_check_deps(e->left.sym);
+		if (sym)
+			return sym;
+		return sym_check_deps(e->right.sym);
+	case E_SYMBOL:
+		return sym_check_deps(e->left.sym);
+	default:
+		break;
+	}
+	fprintf(stderr, "Oops! How to check %d?\n", e->type);
+	return NULL;
+}
+
+/* return NULL when dependencies are OK */
+static struct symbol *sym_check_sym_deps(struct symbol *sym)
+{
+	struct symbol *sym2;
+	struct property *prop;
+	struct dep_stack stack;
+
+	dep_stack_insert(&stack, sym);
+
+	stack.expr = &sym->dir_dep.expr;
+	sym2 = sym_check_expr_deps(sym->dir_dep.expr);
+	if (sym2)
+		goto out;
+
+	stack.expr = &sym->rev_dep.expr;
+	sym2 = sym_check_expr_deps(sym->rev_dep.expr);
+	if (sym2)
+		goto out;
+
+	stack.expr = &sym->implied.expr;
+	sym2 = sym_check_expr_deps(sym->implied.expr);
+	if (sym2)
+		goto out;
+
+	stack.expr = NULL;
+
+	for (prop = sym->prop; prop; prop = prop->next) {
+		if (prop->type == P_CHOICE || prop->type == P_SELECT ||
+		    prop->type == P_IMPLY)
+			continue;
+		stack.prop = prop;
+		sym2 = sym_check_expr_deps(prop->visible.expr);
+		if (sym2)
+			break;
+		if (prop->type != P_DEFAULT || sym_is_choice(sym))
+			continue;
+		stack.expr = &prop->expr;
+		sym2 = sym_check_expr_deps(prop->expr);
+		if (sym2)
+			break;
+		stack.expr = NULL;
+	}
+
+out:
+	dep_stack_remove();
+
+	return sym2;
+}
+
+static struct symbol *sym_check_choice_deps(struct symbol *choice)
+{
+	struct symbol *sym, *sym2;
+	struct property *prop;
+	struct expr *e;
+	struct dep_stack stack;
+
+	dep_stack_insert(&stack, choice);
+
+	prop = sym_get_choice_prop(choice);
+	expr_list_for_each_sym(prop->expr, e, sym)
+		sym->flags |= (SYMBOL_CHECK | SYMBOL_CHECKED);
+
+	choice->flags |= (SYMBOL_CHECK | SYMBOL_CHECKED);
+	sym2 = sym_check_sym_deps(choice);
+	choice->flags &= ~SYMBOL_CHECK;
+	if (sym2)
+		goto out;
+
+	expr_list_for_each_sym(prop->expr, e, sym) {
+		sym2 = sym_check_sym_deps(sym);
+		if (sym2)
+			break;
+	}
+out:
+	expr_list_for_each_sym(prop->expr, e, sym)
+		sym->flags &= ~SYMBOL_CHECK;
+
+	if (sym2 && sym_is_choice_value(sym2) &&
+	    prop_get_symbol(sym_get_choice_prop(sym2)) == choice)
+		sym2 = choice;
+
+	dep_stack_remove();
+
+	return sym2;
+}
+
+struct symbol *sym_check_deps(struct symbol *sym)
+{
+	struct symbol *sym2;
+	struct property *prop;
+
+	if (sym->flags & SYMBOL_CHECK) {
+		sym_check_print_recursive(sym);
+		return sym;
+	}
+	if (sym->flags & SYMBOL_CHECKED)
+		return NULL;
+
+	if (sym_is_choice_value(sym)) {
+		struct dep_stack stack;
+
+		/* for choice groups start the check with main choice symbol */
+		dep_stack_insert(&stack, sym);
+		prop = sym_get_choice_prop(sym);
+		sym2 = sym_check_deps(prop_get_symbol(prop));
+		dep_stack_remove();
+	} else if (sym_is_choice(sym)) {
+		sym2 = sym_check_choice_deps(sym);
+	} else {
+		sym->flags |= (SYMBOL_CHECK | SYMBOL_CHECKED);
+		sym2 = sym_check_sym_deps(sym);
+		sym->flags &= ~SYMBOL_CHECK;
+	}
+
+	return sym2;
+}
+
+struct symbol *prop_get_symbol(struct property *prop)
+{
+	if (prop->expr && (prop->expr->type == E_SYMBOL ||
+			   prop->expr->type == E_LIST))
+		return prop->expr->left.sym;
+	return NULL;
+}
+
+const char *prop_get_type_name(enum prop_type type)
+{
+	switch (type) {
+	case P_PROMPT:
+		return "prompt";
+	case P_COMMENT:
+		return "comment";
+	case P_MENU:
+		return "menu";
+	case P_DEFAULT:
+		return "default";
+	case P_CHOICE:
+		return "choice";
+	case P_SELECT:
+		return "select";
+	case P_IMPLY:
+		return "imply";
+	case P_RANGE:
+		return "range";
+	case P_SYMBOL:
+		return "symbol";
+	case P_UNKNOWN:
+		break;
+	}
+	return "unknown";
+}
diff --git a/backport/kconf/update-upstream-kconfig.sh b/backport/kconf/update-upstream-kconfig.sh
new file mode 100755
index 000000000000..6701919e890d
--- /dev/null
+++ b/backport/kconf/update-upstream-kconfig.sh
@@ -0,0 +1,28 @@
+#!/bin/bash
+
+UPSTREAM="$HOME/linux-next/"
+
+KCONFIG_UPSTREAM="conf.c"
+KCONFIG_UPSTREAM="$KCONFIG_UPSTREAM confdata.c"
+KCONFIG_UPSTREAM="$KCONFIG_UPSTREAM expr.c"
+KCONFIG_UPSTREAM="$KCONFIG_UPSTREAM expr.h"
+KCONFIG_UPSTREAM="$KCONFIG_UPSTREAM list.h"
+KCONFIG_UPSTREAM="$KCONFIG_UPSTREAM lkc.h"
+KCONFIG_UPSTREAM="$KCONFIG_UPSTREAM lkc_proto.h"
+KCONFIG_UPSTREAM="$KCONFIG_UPSTREAM lxdialog"
+KCONFIG_UPSTREAM="$KCONFIG_UPSTREAM mconf.c"
+KCONFIG_UPSTREAM="$KCONFIG_UPSTREAM mconf-cfg.sh"
+KCONFIG_UPSTREAM="$KCONFIG_UPSTREAM menu.c"
+KCONFIG_UPSTREAM="$KCONFIG_UPSTREAM nconf.c"
+KCONFIG_UPSTREAM="$KCONFIG_UPSTREAM nconf-cfg.sh"
+KCONFIG_UPSTREAM="$KCONFIG_UPSTREAM nconf.gui.c"
+KCONFIG_UPSTREAM="$KCONFIG_UPSTREAM nconf.h"
+KCONFIG_UPSTREAM="$KCONFIG_UPSTREAM preprocess.c"
+KCONFIG_UPSTREAM="$KCONFIG_UPSTREAM symbol.c"
+KCONFIG_UPSTREAM="$KCONFIG_UPSTREAM util.c"
+KCONFIG_UPSTREAM="$KCONFIG_UPSTREAM lexer.l"
+KCONFIG_UPSTREAM="$KCONFIG_UPSTREAM parser.y"
+
+for i in $KCONFIG_UPSTREAM; do
+	cp -a $UPSTREAM/scripts/kconfig/$i .
+done
diff --git a/backport/kconf/util.c b/backport/kconf/util.c
new file mode 100644
index 000000000000..29585394df71
--- /dev/null
+++ b/backport/kconf/util.c
@@ -0,0 +1,129 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2002-2005 Roman Zippel <zippel@linux-m68k.org>
+ * Copyright (C) 2002-2005 Sam Ravnborg <sam@ravnborg.org>
+ */
+
+#include <stdarg.h>
+#include <stdlib.h>
+#include <string.h>
+#include "lkc.h"
+
+/* file already present in list? If not add it */
+struct file *file_lookup(const char *name)
+{
+	struct file *file;
+
+	for (file = file_list; file; file = file->next) {
+		if (!strcmp(name, file->name)) {
+			return file;
+		}
+	}
+
+	file = xmalloc(sizeof(*file));
+	memset(file, 0, sizeof(*file));
+	file->name = xstrdup(name);
+	file->next = file_list;
+	file_list = file;
+	return file;
+}
+
+/* Allocate initial growable string */
+struct gstr str_new(void)
+{
+	struct gstr gs;
+	gs.s = xmalloc(sizeof(char) * 64);
+	gs.len = 64;
+	gs.max_width = 0;
+	strcpy(gs.s, "\0");
+	return gs;
+}
+
+/* Free storage for growable string */
+void str_free(struct gstr *gs)
+{
+	if (gs->s)
+		free(gs->s);
+	gs->s = NULL;
+	gs->len = 0;
+}
+
+/* Append to growable string */
+void str_append(struct gstr *gs, const char *s)
+{
+	size_t l;
+	if (s) {
+		l = strlen(gs->s) + strlen(s) + 1;
+		if (l > gs->len) {
+			gs->s = xrealloc(gs->s, l);
+			gs->len = l;
+		}
+		strcat(gs->s, s);
+	}
+}
+
+/* Append printf formatted string to growable string */
+void str_printf(struct gstr *gs, const char *fmt, ...)
+{
+	va_list ap;
+	char s[10000]; /* big enough... */
+	va_start(ap, fmt);
+	vsnprintf(s, sizeof(s), fmt, ap);
+	str_append(gs, s);
+	va_end(ap);
+}
+
+/* Retrieve value of growable string */
+const char *str_get(struct gstr *gs)
+{
+	return gs->s;
+}
+
+void *xmalloc(size_t size)
+{
+	void *p = malloc(size);
+	if (p)
+		return p;
+	fprintf(stderr, "Out of memory.\n");
+	exit(1);
+}
+
+void *xcalloc(size_t nmemb, size_t size)
+{
+	void *p = calloc(nmemb, size);
+	if (p)
+		return p;
+	fprintf(stderr, "Out of memory.\n");
+	exit(1);
+}
+
+void *xrealloc(void *p, size_t size)
+{
+	p = realloc(p, size);
+	if (p)
+		return p;
+	fprintf(stderr, "Out of memory.\n");
+	exit(1);
+}
+
+char *xstrdup(const char *s)
+{
+	char *p;
+
+	p = strdup(s);
+	if (p)
+		return p;
+	fprintf(stderr, "Out of memory.\n");
+	exit(1);
+}
+
+char *xstrndup(const char *s, size_t n)
+{
+	char *p;
+
+	p = strndup(s, n);
+	if (p)
+		return p;
+	fprintf(stderr, "Out of memory.\n");
+	exit(1);
+}
-- 
2.30.2


--
To unsubscribe from this list: send the line "unsubscribe backports" in
