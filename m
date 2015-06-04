Return-path: <backports-owner@vger.kernel.org>
Received: from hauke-m.de ([5.39.93.123]:35863 "EHLO hauke-m.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752331AbbFDJYl (ORCPT <rfc822;backports@vger.kernel.org>);
	Thu, 4 Jun 2015 05:24:41 -0400
Message-ID: <55701954.101@hauke-m.de> (sfid-20150604_112444_559605_5E212435)
Date: Thu, 04 Jun 2015 11:24:36 +0200
From: Hauke Mehrtens <hauke@hauke-m.de>
MIME-Version: 1.0
To: Arend van Spriel <arend@broadcom.com>,
	"backports@vger.kernel.org" <backports@vger.kernel.org>
Subject: Re: how to deal with coccinelle version requirements
References: <55701831.20700@broadcom.com>
In-Reply-To: <55701831.20700@broadcom.com>
Content-Type: text/plain; charset=windows-1252
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

On 06/04/2015 11:19 AM, Arend van Spriel wrote:
> I am running a build server on Ubuntu 14.04 and recently had to upgrade
> coccinelle for backports builds. So I got my hands on a debian package
> (from launchpad if I recall correctly) and installing it manually gives
> me following warning:
> 
> $ sudo dpkg -i coccinelle_1.0.0~rc24.deb-1_amd64.deb
> Selecting previously unselected package coccinelle.
> (Reading database ... 309776 files and directories currently installed.)
> Preparing to unpack coccinelle_1.0.0~rc24.deb-1_amd64.deb ...
> Unpacking coccinelle (1.0.0~rc24.deb-1) ...
> dpkg: dependency problems prevent configuration of coccinelle:
>  coccinelle depends on libpcre3 (>= 1:8.35); however:
>   Version of libpcre3:amd64 on system is 1:8.31-2ubuntu2.
> 
> dpkg: error processing package coccinelle (--install):
>  dependency problems - leaving unconfigured
> Processing triggers for man-db (2.6.7.1-1) ...
> Errors were encountered while processing:
>  coccinelle
> 
> Now spatch is installed and works just fine, but I am getting all kinds
> of errors when trying to install other packages which kinda sucks. So I
> tried unstalling coccinelle and just build it from github repo, but that
> fails for me as well (giving 'Unbound module Pcre').
> 
> So can anyone recommend a way to deal with the coccinelle version
> requirements when running on Ubuntu LTS version.
> 
> Regards,
> Arend

I also took the package from debian on my Ubuntu system, but I also
installed a more recent version of libpcre3, because coccinelle requires
it and is complaining about this in your error message. I used this
package: http://packages.ubuntu.com/utopic/libpcre3

Hauke
