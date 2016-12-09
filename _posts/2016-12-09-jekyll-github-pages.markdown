---
layout: post
title:  "Jekyll and Github Pages"
date:   2016-12-09
categories: jekyll github pages
---

Setting up github pages is [easy][github pages setup].  
You can even set them up to your favorite flavor of Jekyll!  
However, should you want to do that (as of Dec 2016), you might find yourself cursing a bit more than usual.  

Most of the problems you are likely to encounter immediately are related to the markdown engine.  It works slightly differently locally compared to github.  
Github pages now support only *kramdown* as a markdown converter. Therefore, should you try to use any other markdown converter, you'll get an angry email warning you that your formatting might fail at any time. Interestingly (and surprisingly), other converters, in particular *redcarpet*, lack the current drawbacks of *kramdown*.
Good news is that those drawbacks simply boil down to a handful of quirks, rather than real problems.

### Fantastic Kramdown Quirks and How to Fight Them

* Two subsequent headers must have a break of one or more lines between them.  
Otherwise, the header, following the first one, won't be interpreted. 
* Code formatting using \`\`\` and ~~~ has more limitations than "liquid tags".  
In particular, code highlighted in such manner must be separated from the preceding text by one or more lines.
* Lists have to be separated from the preceding text by one or more lines.

	
	
[github pages setup]: https://pages.github.com/