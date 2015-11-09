Return-path: <backports-owner@vger.kernel.org>
Received: from mail-yk0-f169.google.com ([209.85.160.169]:35744 "EHLO
	mail-yk0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752662AbbKIQXM (ORCPT
	<rfc822;backports@vger.kernel.org>); Mon, 9 Nov 2015 11:23:12 -0500
Received: by ykek133 with SMTP id k133so273119655yke.2
        for <backports@vger.kernel.org>; Mon, 09 Nov 2015 08:23:12 -0800 (PST)
Subject: Re: Realtek RTL8192DU Driver and Android LOllipop
To: anjalik@iwavesystems.com, backports@vger.kernel.org
References: <20151109054901.52833inkm5vggbh9@iwavesystems.com>
From: Larry Finger <Larry.Finger@lwfinger.net>
Message-ID: <5640C86D.2090804@lwfinger.net> (sfid-20151109_172320_658348_F542138F)
Date: Mon, 9 Nov 2015 10:23:09 -0600
MIME-Version: 1.0
In-Reply-To: <20151109054901.52833inkm5vggbh9@iwavesystems.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

On 11/09/2015 04:49 AM, anjalik@iwavesystems.com wrote:
> Hi ,
>
>   I am working on a project on Android Lollipop and I need to use Realtek Wi-Fi
> Driver RTL8192DU . The Linux kernel version used in Android LOllipop is 3.10.53.
> And I am getting compile time error during the ko file generation due to many
> deperecated APIS used in the driver.
>
> Have u released or worked on Realtek Wi-Fi Driver RTL8192DU for the above
> mentioned Linux kernel?

Backports can only backport drivers that are in the kernel. For several reasons, 
the driver for RTL8192DU has never been submitted for inclusion.

The vendor driver for your device has been updated for later kernels and posted 
at http://github.com/lwfinger/rtl8192du.git. If that one does not build on your 
3.10 kernel, please report an issue for it at GitHub.

Larry


--
To unsubscribe from this list: send the line "unsubscribe backports" in
