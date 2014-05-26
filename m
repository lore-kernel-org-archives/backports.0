Return-path: <backports-owner@vger.kernel.org>
Received: from mail-gw3-out.broadcom.com ([216.31.210.64]:17009 "EHLO
	mail-gw3-out.broadcom.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752079AbaEZNoV (ORCPT
	<rfc822;backports@vger.kernel.org>); Mon, 26 May 2014 09:44:21 -0400
Message-ID: <53834533.8030800@broadcom.com> (sfid-20140526_154423_747475_7D28322D)
Date: Mon, 26 May 2014 15:44:19 +0200
From: Arend van Spriel <arend@broadcom.com>
MIME-Version: 1.0
To: Fariya <fariyaf@gmail.com>
CC: <backports@vger.kernel.org>
Subject: Re: Procedure to make the driver into the backports project
References: <CAG+h2qgoudEKwwL7pwYAaSbwvtJw4efi3e_or1yq0YOLm98fuQ@mail.gmail.com>
In-Reply-To: <CAG+h2qgoudEKwwL7pwYAaSbwvtJw4efi3e_or1yq0YOLm98fuQ@mail.gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

On 05/26/14 11:47, Fariya wrote:
> Hi,
>
> My company's wireless driver is a part of the latest 3.15-rc kernel.
> My question is pertaining to the backports project. How does the
> procedure at backports work? Will my driver be picked up and
> backported by the backports group now that it is part of the kernel or
> the owner of the driver needs to backport the driver [for various
> kernels] and provide it on to this mailing list initially?

The backport repo does not hold a backported driver, but a framework to 
create a package of the latest drivers which can be automatically 
backported to various kernels.

When you check out the backports repository on kernel.org there is a 
copy-list file which lists everything that is copied from the kernel 
tree to be included in the backport package. First step would be to add 
you driver to that list. If you are lucky that might be sufficient.

Regards,
Arend

> Regards,
> Fariya
> --
> To unsubscribe from this list: send the line "unsubscribe backports" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

