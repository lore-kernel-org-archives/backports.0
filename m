Return-Path: <mcgrof+caf_=mcgrof=gmail.com@frijolero.org>
Return-Path: <backports-owner@vger.kernel.org>
Received: from quad.pendre.co.uk ([195.137.4.79]:52418 "EHLO quad.pendre.co.uk"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933331Ab2JDAjs (ORCPT <rfc822;backports@vger.kernel.org>);
	Wed, 3 Oct 2012 20:39:48 -0400
Received: from localhost (Quad [127.0.0.1])
	by quad.pendre.co.uk (Postfix) with ESMTP id 480C7194006
	for <backports@vger.kernel.org>; Thu,  4 Oct 2012 01:28:54 +0100 (BST)
Received: from [192.168.0.1] (pendre.co.uk [192.168.0.1])
	by quad.pendre.co.uk (Postfix) with ESMTP id D1399194004
	for <backports@vger.kernel.org>; Thu,  4 Oct 2012 01:28:53 +0100 (BST)
Message-ID: <506CD845.9030208@elrepo.org>
Date: Thu, 04 Oct 2012 01:28:53 +0100
From: Phil Perry <phil@elrepo.org>
MIME-Version: 1.0
To: backports@vger.kernel.org
Subject: Re: Compat-wireless release for 2012-10-03 is baked
References: <20121003205658.6DF3D40ABF@repository3.orbit-lab.org>
In-Reply-To: <20121003205658.6DF3D40ABF@repository3.orbit-lab.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

On 03/10/12 21:56, Compat-wireless cronjob account wrote:
> git fetch github (/var/opt/compat/compat-wireless-2.6)
> HEAD is now at 7110a5c compat-drivers: copy over amp.h as a bluetooth header
> git fetch github (/var/opt/compat/compat)
> HEAD is now at fb4936e compat: backport seq_file's user namespace addition
> git fetch  (/var/opt/compat/linux-next)
> Nothing new to pack.
> HEAD is now at 25444c3 Add linux-next specific files for 20121003
> Trying kernel 3.4.4-030404-generic [OK]
> Trying kernel 3.3.7-030307-generic [OK]
> Trying kernel 3.2.2-030202-generic [OK]
> Trying kernel 3.1.10-030110-generic [OK]
> Trying kernel 3.0.18-030018-generic [OK]
> Trying kernel 2.6.39-02063904-generic [OK]
> Trying kernel 2.6.38-02063808-generic [OK]
> Trying kernel 2.6.37-02063706-generic [OK]
> Trying kernel 2.6.36-02063604-generic [OK]
> Trying kernel 2.6.35-02063512-generic [OK]
> Trying kernel 2.6.34-02063410-generic [OK]
> Trying kernel 2.6.33-02063305-generic [OK]

Just curious, any reason kernel 2.6.32 is always missing?

> Trying kernel 2.6.31-02063113-generic [OK]
> Trying kernel 2.6.30-02063010-generic [OK]
> Trying kernel 2.6.29-02062906-generic [OK]
> Trying kernel 2.6.28-02062810-generic [OK]
> Trying kernel 2.6.27-020627-generic [OK]
> Trying kernel 2.6.26-020626-generic [OK]
> Trying kernel 2.6.25-020625-generic [OK]
> Trying kernel 2.6.24-020624-generic [OK]
> Worked!
>
