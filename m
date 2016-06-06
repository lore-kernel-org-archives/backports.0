Return-path: <backports-owner@vger.kernel.org>
Received: from smtp6-v.fe.bosch.de ([139.15.237.11]:54517 "EHLO
	smtp6-v.fe.bosch.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751125AbcFFGRo convert rfc822-to-8bit (ORCPT
	<rfc822;backports@vger.kernel.org>); Mon, 6 Jun 2016 02:17:44 -0400
From: "HUANG Weller (CM/ESW12-CN)" <Weller.Huang@cn.bosch.com>
To: Arend van Spriel <arend.vanspriel@broadcom.com>,
	"gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
	"jack@suse.cz" <jack@suse.cz>, "tytso@mit.edu" <tytso@mit.edu>,
	"backports@vger.kernel.org" <backports@vger.kernel.org>
CC: "stable@vger.kernel.org" <stable@vger.kernel.org>,
	"Behme Dirk (CM/ESO2)" <Dirk.Behme@de.bosch.com>,
	"Juergens Dirk (CM/ESO2)" <Dirk.Juergens@de.bosch.com>
Subject: RE: FAILED: patch "[PATCH] ext4: fix data exposure after a crash"
 failed to apply to 3.14-stable tree
Date: Mon, 6 Jun 2016 06:17:38 +0000
Message-ID: <3aaf6022009f4a759d4edaed1fba0cf6@SGPMBX1004.APAC.bosch.com> (sfid-20160606_081747_198565_B8482B22)
References: <146507681324370@kroah.com>
 <14e1b621c63d4053afe540c9ae623f8e@SGPMBX1004.APAC.bosch.com>
 <57550738.1090200@broadcom.com>
In-Reply-To: <57550738.1090200@broadcom.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

Hi Arend,

I am sorry for this misunderstanding.
Yes, I remember Jan Kara told me before.

Best regards

 Weller HUANG



> -----Original Message-----
> From: Arend van Spriel [mailto:arend.vanspriel@broadcom.com]
> Sent: Monday, June 06, 2016 1:17 PM
> To: HUANG Weller (CM/ESW12-CN) <Weller.Huang@cn.bosch.com>;
> gregkh@linuxfoundation.org; jack@suse.cz; tytso@mit.edu;
> backports@vger.kernel.org
> Cc: stable@vger.kernel.org; Behme Dirk (CM/ESO2)
> <Dirk.Behme@de.bosch.com>; Juergens Dirk (CM/ESO2)
> <Dirk.Juergens@de.bosch.com>
> Subject: Re: FAILED: patch "[PATCH] ext4: fix data exposure after a crash" failed
> to apply to 3.14-stable tree
> 
> On 06-06-16 02:02, HUANG Weller (CM/ESW12-CN) wrote:
> > Hi backports team,
> >
> > Could you please apply the below patch to the 3.14-stable tree ?
> 
> Hi Huang,
> 
> I suspect you are talking to the wrong crowd. Backports is a project to generate a
> source package of latest kernel code which can be compiled against older target
> kernels.
> 
> What is meant in Greg's (automated) response is that the patch should be
> backported manually so it applies to 3.14-stable tree. This is something Jan Kara
> should take care of if he cares about getting this patch in 3.14-stable.
> 
> Regards,
> Arend
> 
> > Thanks.
> > Best regards
> >
> >  Weller HUANG
> >
> >
> >
> >> -----Original Message-----
> >> From: gregkh@linuxfoundation.org [mailto:gregkh@linuxfoundation.org]
> >> Sent: Sunday, June 05, 2016 5:47 AM
> >> To: jack@suse.cz; HUANG Weller (CM/ESW12-CN)
> >> <Weller.Huang@cn.bosch.com>; tytso@mit.edu
> >> Cc: stable@vger.kernel.org
> >> Subject: FAILED: patch "[PATCH] ext4: fix data exposure after a
> >> crash" failed to apply to 3.14-stable tree
> >>
> >>
> >> The patch below does not apply to the 3.14-stable tree.
> >> If someone wants it applied there, or to any other stable or longterm
> >> tree, then please email the backport, including the original git
> >> commit id to <stable@vger.kernel.org>.
> >>
> >> thanks,
> >>
> >> greg k-h
> >>
> >> ------------------ original commit in Linus's tree ------------------
> >>
> >> From 06bd3c36a733ac27962fea7d6f47168841376824 Mon Sep 17 00:00:00
> >> 2001
> >> From: Jan Kara <jack@suse.cz>
> >> Date: Sun, 24 Apr 2016 00:56:03 -0400
> >> Subject: [PATCH] ext4: fix data exposure after a crash
> >>
> >> Huang has reported that in his powerfail testing he is seeing stale
> >> block contents in some of recently allocated blocks although he
> >> mounts
> >> ext4 in data=ordered mode. After some investigation I have found out
> >> that indeed when delayed allocation is used, we don't add inode to
> >> transaction's list of inodes needing flushing before commit.
> >> Originally we were doing that but commit f3b59291a69d removed the logic with
> a flawed argument that it is not needed.
> >>
> >> The problem is that although for delayed allocated blocks we write
> >> their contents immediately after allocating them, there is no
> >> guarantee that the IO scheduler or device doesn't reorder things and
> >> thus transaction allocating blocks and attaching them to inode can
> >> reach stable storage before actual block contents. Actually whenever
> >> we attach freshly allocated blocks to inode using a written extent,
> >> we should add inode to transaction's ordered inode list to make sure
> >> we properly wait for block contents to be written before committing
> >> the transaction. So that is what we do in this patch. This also handles other
> cases where stale data exposure was possible - like filling hole via mmap in
> data=ordered,nodelalloc mode.
> >>
> >> The only exception to the above rule are extending direct IO writes
> >> where
> >> blkdev_direct_IO() waits for IO to complete before increasing i_size
> >> and thus stale data exposure is not possible. For now we don't
> >> complicate the code with optimizing this special case since the
> >> overhead is pretty low. In case this is observed to be a performance
> >> problem we can always handle it using a special flag to ext4_map_blocks().
> >>
> >> CC: stable@vger.kernel.org
> >> Fixes: f3b59291a69d0b734be1fc8be489fef2dd846d3d
> >> Reported-by: "HUANG Weller (CM/ESW12-CN)" <Weller.Huang@cn.bosch.com>
> >> Tested-by: "HUANG Weller (CM/ESW12-CN)" <Weller.Huang@cn.bosch.com>
> >> Signed-off-by: Jan Kara <jack@suse.cz>
> >> Signed-off-by: Theodore Ts'o <tytso@mit.edu>
> >>
> >> diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c index
> >> 981a1fc30eaa..250c2df04a92
> >> 100644
> >> --- a/fs/ext4/inode.c
> >> +++ b/fs/ext4/inode.c
> >> @@ -684,6 +684,21 @@ out_sem:
> >>  		ret = check_block_validity(inode, map);
> >>  		if (ret != 0)
> >>  			return ret;
> >> +
> >> +		/*
> >> +		 * Inodes with freshly allocated blocks where contents will be
> >> +		 * visible after transaction commit must be on transaction's
> >> +		 * ordered data list.
> >> +		 */
> >> +		if (map->m_flags & EXT4_MAP_NEW &&
> >> +		    !(map->m_flags & EXT4_MAP_UNWRITTEN) &&
> >> +		    !(flags & EXT4_GET_BLOCKS_ZERO) &&
> >> +		    !IS_NOQUOTA(inode) &&
> >> +		    ext4_should_order_data(inode)) {
> >> +			ret = ext4_jbd2_file_inode(handle, inode);
> >> +			if (ret)
> >> +				return ret;
> >> +		}
> >>  	}
> >>  	return retval;
> >>  }
> >> @@ -1289,15 +1304,6 @@ static int ext4_write_end(struct file *file,
> >>  	int i_size_changed = 0;
> >>
> >>  	trace_ext4_write_end(inode, pos, len, copied);
> >> -	if (ext4_test_inode_state(inode, EXT4_STATE_ORDERED_MODE)) {
> >> -		ret = ext4_jbd2_file_inode(handle, inode);
> >> -		if (ret) {
> >> -			unlock_page(page);
> >> -			put_page(page);
> >> -			goto errout;
> >> -		}
> >> -	}
> >> -
> >>  	if (ext4_has_inline_data(inode)) {
> >>  		ret = ext4_write_inline_data_end(inode, pos, len,
> >>  						 copied, page);
> >
> > --
> > To unsubscribe from this list: send the line "unsubscribe backports"
> > in
> >
--
To unsubscribe from this list: send the line "unsubscribe backports" in
