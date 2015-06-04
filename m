Return-path: <backports-owner@vger.kernel.org>
Received: from mail-gw1-out.broadcom.com ([216.31.210.62]:46839 "EHLO
	mail-gw1-out.broadcom.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753111AbbFDJTt (ORCPT
	<rfc822;backports@vger.kernel.org>); Thu, 4 Jun 2015 05:19:49 -0400
Received: from [10.176.128.60] (xl-bun-02.bun.broadcom.com [10.176.128.60])	by
 mail-sj1-12.sj.broadcom.com (Postfix) with ESMTP id D7B9B27A8B	for
 <backports@vger.kernel.org>; Thu,  4 Jun 2015 02:19:46 -0700 (PDT)
Message-ID: <55701831.20700@broadcom.com> (sfid-20150604_112017_589556_586FC9D1)
Date: Thu, 4 Jun 2015 11:19:45 +0200
From: Arend van Spriel <arend@broadcom.com>
MIME-Version: 1.0
To: "backports@vger.kernel.org" <backports@vger.kernel.org>
Subject: how to deal with coccinelle version requirements
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

I am running a build server on Ubuntu 14.04 and recently had to upgrade 
coccinelle for backports builds. So I got my hands on a debian package 
(from launchpad if I recall correctly) and installing it manually gives 
me following warning:

$ sudo dpkg -i coccinelle_1.0.0~rc24.deb-1_amd64.deb
Selecting previously unselected package coccinelle.
(Reading database ... 309776 files and directories currently installed.)
Preparing to unpack coccinelle_1.0.0~rc24.deb-1_amd64.deb ...
Unpacking coccinelle (1.0.0~rc24.deb-1) ...
dpkg: dependency problems prevent configuration of coccinelle:
  coccinelle depends on libpcre3 (>= 1:8.35); however:
   Version of libpcre3:amd64 on system is 1:8.31-2ubuntu2.

dpkg: error processing package coccinelle (--install):
  dependency problems - leaving unconfigured
Processing triggers for man-db (2.6.7.1-1) ...
Errors were encountered while processing:
  coccinelle

Now spatch is installed and works just fine, but I am getting all kinds 
of errors when trying to install other packages which kinda sucks. So I 
tried unstalling coccinelle and just build it from github repo, but that 
fails for me as well (giving 'Unbound module Pcre').

So can anyone recommend a way to deal with the coccinelle version 
requirements when running on Ubuntu LTS version.

Regards,
Arend
