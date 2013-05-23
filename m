Return-path: <backports-owner@vger.kernel.org>
Received: from s3.sipsolutions.net ([144.76.43.152]:35122 "EHLO
	sipsolutions.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751184Ab3EWQGW (ORCPT
	<rfc822;backports@vger.kernel.org>); Thu, 23 May 2013 12:06:22 -0400
Message-ID: <1369325176.12002.31.camel@jlt4.sipsolutions.net> (sfid-20130523_180624_786621_DB54A143)
Subject: Re: [PATCH v3 8/8] gentree.py: add kernel upload support
From: Johannes Berg <johannes@sipsolutions.net>
To: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>
Cc: backports@vger.kernel.org
Date: Thu, 23 May 2013 18:06:16 +0200
In-Reply-To: <1369278956-17550-9-git-send-email-mcgrof@do-not-panic.com> (sfid-20130523_051647_045037_8195DCDD)
References: <1369278956-17550-1-git-send-email-mcgrof@do-not-panic.com>
	 <1369278956-17550-9-git-send-email-mcgrof@do-not-panic.com>
	 (sfid-20130523_051647_045037_8195DCDD)
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>


> +def get_rel_spec_stable(rel):
> +    """
> +    Returns release specs for a linux-stable backports based release.
> +    """
> +    if ("rc" in rel):

I really think you should drop those parentheses on ifs, it looks
weirdly C-ish and this is python :-)

> +        m = re.match(r"(?P<VERSION>\d+)\.+" \
> +                     "(?P<PATCHLEVEL>\d+)[.]*" \
> +                     "(?P<SUBLEVEL>\d*)" \
> +                     "[-rc]+(?P<RC_VERSION>\d+)\-+" \

"[-rc]+" seems weird, don't you just want "(-rc)?". And then in fact I
think you don't need the "if rc in" above?

> +    if (not m):

ditto

> +    m = re.match(r"(?P<DATE_VERSION>\d+)[-]*" \

"[-]*" is odd, why not just write "-*" if that's what you want? Maybe
you actually want "-+", otherwise there's no boundary between
DATE_VERSION and RELMOD_UPDATE.

> +    if (not rel_specs):
> +        rel_specs = get_rel_spec_next(rel)
> +        if (not rel_specs):
> +            sys.stdout.write("rel: %s\n" % rel)

print ?

> +        paths.append(year)
> +        paths.append(month)
> +        paths.append(day)
> +        rel_tag = "backports-" + rel.replace(rel_specs['RELMOD_TYPE'], "")
> +    else:
> +        ignore = "-"
> +        if (not rel_specs['RELMOD_UPDATE']):
> +            return None
> +        if (rel_specs['RELMOD_UPDATE'] == '0'):
> +            return None
> +        ignore += rel_specs['RELMOD_UPDATE']
> +        if (rel_specs['RELMOD_TYPE'] != ''):
> +            ignore += rel_specs['RELMOD_TYPE']
> +        base_rel = rel.replace(ignore, "")
> +        paths.append(base_rel)
> +        rel_tag = "v" + rel.replace(rel_specs['RELMOD_TYPE'], "")
> +
> +    rel_prep = dict(stable = is_stable,
> +                    expected_tag = rel_tag,
> +                    paths_to_create = paths)
> +    return rel_prep

I truly don't understand this function. Also, what's with the dict? Why
not just return a tuple:
	return (is_stable, rel_tag, paths)

> +    parent = os.path.dirname(args.outdir)
> +    release = os.path.basename(args.outdir)
> +    tar_name = parent + '/' + release + ".tar"
> +    bzip2_name = tar_name + ".bz2"
> +
> +    create_tar_and_bz2(tar_name, args.outdir)

I'd recommend creating it in a temporary directory. In fact, I'd
recommend making args.outdir optional in this case (which needs some
refactoring) and making _it_ a subdir in a temp directory too?


> @@ -289,16 +464,22 @@ def _main():
>                     git_revision=args.git_revision, clean=args.clean,
>                     refresh=args.refresh, base_name=args.base_name,
>                     gitdebug=args.gitdebug, verbose=args.verbose,
> -                   extra_driver=args.extra_driver, logwrite=logwrite)
> +                   extra_driver=args.extra_driver,
> +                   kup=args.kup,
> +                   kup_test=args.kup_test,
> +                   logwrite=logwrite)
>  
>  def process(kerneldir, outdir, copy_list_file, git_revision=None,
>              clean=False, refresh=False, base_name="Linux", gitdebug=False,
> -            verbose=False, extra_driver=[], logwrite=lambda x:None,
> +            verbose=False, extra_driver=[], kup=False,
> +            kup_test=False,
> +            logwrite=lambda x:None,
>              git_tracked_version=False):

That may just be me, but maybe you should be consistent and put more
things on one line (or reformat the other lines?)

> @@ -309,10 +490,48 @@ def process(kerneldir, outdir, copy_list_file, git_revision=None,
>              self.gitdebug = gitdebug
>              self.verbose = verbose
>              self.extra_driver = extra_driver
> +            self.kup = kup
> +            self.kup_test = kup_test
> +    def git_paranoia(tree=None, logwrite=lambda x:None):

This is a really strange place to define a function?

>      # start processing ...
> +    if (args.kup or args.kup_test):
> +        git_paranoia(source_dir, logwrite)

This part might not be handled by my git-revision suggestion, but then
maybe it'd be better to actually point the scripting to a 

> +        git_paranoia(kerneldir, logwrite)
> +
> +        rel_describe = git.describe(rev=None, tree=source_dir, extra_args=['--dirty'])
> +        release = os.path.basename(args.outdir)

Taking the file path for a release description seems like a strange
thing to do? Maybe you should pass it on the command line?

johannes

