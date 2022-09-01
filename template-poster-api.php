<?php
/**
 * Template Name: Posters Page
 * 
 * Wordpress Page Template file designed to work with:
 * https://github.com/cveerkamp/poster-manage
 * 
 */
?>
<?php while ( have_posts() ) : the_post(); ?>
<?php
    //Print out a unique key using a combination of today's date and the post revision ID.  This has will change daily or whenever post is updated
    $d=date("Ymd");
    echo md5(array_key_first(wp_get_post_revisions(get_the_ID(),ARRAY_A)).$d)."\n";
    //Extract the image URLs from all <img> tags in the post body
    preg_match_all('/(href|src)\s*=\s*"([^\s]+\/\/[^\/]+.\/[^\s]+\.(jpg|jpeg|png|gif|bmp))/ixu',trim(strip_tags(get_the_content(),"<img>")),$out);
    //Print out all the image URLs found, one per line
    echo implode("\n",$out[2]);
?>
<?php endwhile; ?>