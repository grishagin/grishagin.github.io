---
layout: post
title:  "Jekyll and Github Pages"
date:   2016-12-09
categories: jekyll
---

Setting up github pages is [easy][github pages setup].  
You can even set them up to your favorite flavor of [Jekyll][jekyll]!  
However, should you want to do that (as of Dec 2016), you might find yourself cursing a bit more than usual.  

Most of the problems you are likely to encounter immediately are related to the markdown engine.  It works slightly differently locally compared to github.  
Github pages now support only *kramdown* as a markdown converter. Therefore, should you try to use any other markdown converter, you'll get an angry email warning you that your formatting might fail at any time. Interestingly (and surprisingly), other converters, in particular *redcarpet*, lack the current drawbacks of *kramdown*.
Good news is that those drawbacks simply boil down to a handful of quirks, rather than real problems.

### Fantastic Kramdown Quirks and How to Fight Them

* Two subsequent headers must have a break of one or more lines between them.  
Otherwise, the header, following the first one, won't be interpreted. 

* Code formatting using \`\`\` and ~~~ has more limitations than ["liquid tags"][liquidtags]. 
In particular, code highlighted in such manner must be separated from the preceding text by one or more lines.

* Lists have to be separated from the preceding text by one or more lines.

* A tab in the code *may* be randomly recognized as two tabs. It can be avoided by explicitly replacing such problematic tabs with equivalent number of spaces.

* This one is a really nasty problem: code blocks in lists.  They have to be indented, else they break up the list.  
And here's the problem: a local copy is just fine with a regular tab (or 4 spaces) indentation, yet the github copy needs the **backticks to be aligned with the first letter of the first line of the corresponding list element**, i.e. in a top level list, for example, that would require **only 3, not 4 spaces** of indentation.  
Solution is provided in [github FAQ][codelist]:
  ```
	1.·some text    =>  use 3 spaces indentation e.g.

	   ```
	   $ gem install beerdb
	   ```
  ```
	
	
[github pages setup]: https://pages.github.com/
[jekyll]: https://jekyllrb.com/
[liquidtags]: https://jekyllrb.com/docs/templates/
[codelist]: https://github.com/planetjekyll/quickrefs/blob/master/FAQ.md#q-how-can-i-get-backtick-fenced-code-blocks-eg--working-inside-lists-with-kramdown