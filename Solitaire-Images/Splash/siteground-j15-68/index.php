<?php
defined( '_JEXEC' ) or die( 'Restricted access' );
JPlugin::loadLanguage( 'tpl_SG1' );
?>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="<?php echo $this->language; ?>" lang="<?php echo $this->language; ?>" >
<head>
<jdoc:include type="head" />

<link rel="stylesheet" href="templates/system/css/system.css" type="text/css" />
<link rel="stylesheet" href="templates/<?php echo $this->template ?>/css/template.css" type="text/css" />

<!--[if lte IE 6]>
<link href="templates/<?php echo $this->template ?>/css/ie6.css" rel="stylesheet" type="text/css" />
<![endif]-->

</head>

<body id="page_bg">

	<div id="logo">
		<a href="index.php"><?php echo $mainframe->getCfg('sitename') ;?></a>
	</div>	
	
	<div id="header">
		<div id="headerimg"></div>
		<div id="newsflash">
			<jdoc:include type="modules" style="rounded" name="top" />
		</div>
	</div>
	
	<div id="wrapper">
		<div id="holder">
			<div class="center">
				<div class="pill_m">
					<div id="pillmenu">
						<jdoc:include type="modules" name="user3" />
					</div>
				</div>
				<div id="content">
					<?php if($this->countModules('left') and JRequest::getCmd('layout') != 'form') : ?>
					<div id="leftcolumn">	
						<jdoc:include type="modules" name="left" style="rounded" />
<br /><?php $sg = "banner"; include "templates.php"; ?><br />
						
					</div>
					<?php endif; ?>
					
					<?php if($this->countModules('right') and JRequest::getCmd('layout') != 'form') : ?>			
					<div id="maincolumn">
					<?php else: ?>
					<div id="maincolumn_full">
					<?php endif; ?>
						<div class="nopad">				
							<jdoc:include type="message" />
							<?php if($this->params->get('showComponent')) : ?>
								<jdoc:include type="component" />
							<?php endif; ?>
						</div>
					</div>
					<?php if($this->countModules('right') and JRequest::getCmd('layout') != 'form') : ?>
						<div id="rightcolumn" style="float:right;">
							<jdoc:include type="modules" name="right" style="rounded" />								
						</div>
						<?php endif; ?>
					<div class="clr"></div>
					<jdoc:include type="modules" name="debug" />
				</div>
			</div>	
		</div>	
	</div>
			
		<div id="footer">
			<div id="sgf">
				<?php $sg = ''; include "templates.php"; ?>
			</div>
			
			<div id="validation">
				<a href="http://validator.w3.org/check/referer">valid xhtml</a>
				<a href="http://jigsaw.w3.org/css-validator/check/referer">valid css</a>
			</div>
		</div>
	
</body>
</html>
