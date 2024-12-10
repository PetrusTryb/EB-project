{**
 * Copyright since 2007 PrestaShop SA and Contributors
 * PrestaShop is an International Registered Trademark & Property of PrestaShop SA
 *
 * NOTICE OF LICENSE
 *
 * This source file is subject to the Academic Free License 3.0 (AFL-3.0)
 * that is bundled with this package in the file LICENSE.md.
 * It is also available through the world-wide-web at this URL:
 * https://opensource.org/licenses/AFL-3.0
 * If you did not receive a copy of the license and are unable to
 * obtain it through the world-wide-web, please send an email
 * to license@prestashop.com so we can send you a copy immediately.
 *
 * DISCLAIMER
 *
 * Do not edit or add to this file if you wish to upgrade PrestaShop to newer
 * versions in the future. If you wish to customize PrestaShop for your
 * needs please refer to https://devdocs.prestashop.com/ for more information.
 *
 * @author    PrestaShop SA and Contributors <contact@prestashop.com>
 * @copyright Since 2007 PrestaShop SA and Contributors
 * @license   https://opensource.org/licenses/AFL-3.0 Academic Free License 3.0 (AFL-3.0)
 *}
<div class="product_list_container">
{capture assign="productClasses"}{if !empty($productClass)}{$productClass}{else}col-xs-12 col-sm-6 col-xl-4{/if}{/capture}
<div id="{$type}_next_button" class="next_button">
	<svg class="slider_svg" xmlns="http://www.w3.org/2000/svg" width="32" height="32" viewBox="0 0 20 20">
		<path fill="currentColor" fill-rule="evenodd" d="M7.21 14.77a.75.75 0 0 1 .02-1.06L11.168 10L7.23 6.29a.75.75 0 1 1 1.04-1.08l4.5 4.25a.75.75 0 0 1 0 1.08l-4.5 4.25a.75.75 0 0 1-1.06-.02Z" clip-rule="evenodd"></path>
	</svg>
</div> 
 <div id="{$type}_prev_button" class="prev_button">
	<svg class="slider_svg" xmlns="http://www.w3.org/2000/svg" width="32" height="32" viewBox="0 0 20 20">
		<path fill="currentColor" fill-rule="evenodd" d="M12.79 5.23a.75.75 0 0 1-.02 1.06L8.832 10l3.938 3.71a.75.75 0 1 1-1.04 1.08l-4.5-4.25a.75.75 0 0 1 0-1.08l4.5-4.25a.75.75 0 0 1 1.06.02Z" clip-rule="evenodd"></path>
	</svg>
</div>
<div class="products{if !empty($cssClass)} {$cssClass}{/if}">
	<div  id="{$type}_slider" class="products_wrapper">
    {include file="catalog/_partials/miniatures/custom_product.tpl" type=$type position=$position productClasses=$productClasses}
	</div>
</div>
</div>
<script>
const {$type}_slider = document.getElementById('{$type}_slider');
const {$type}_nextButton = document.getElementById('{$type}_next_button');
const {$type}_prevButton = document.getElementById('{$type}_prev_button');
let {$type}_currentIndex = 0;

const {$type}_totalItems = {$type}_slider.children.length - 1;
const {$type}_visibleItems = 4;
const {$type}_itemWidth = {$type}_slider.querySelector('.product').offsetWidth + 5;
const {$type}_maxIndex = {$type}_totalItems - {$type}_visibleItems;
console.log({$type}_itemWidth, {$type}_totalItems, {$type}_visibleItems, {$type}_maxIndex);
if ({$type}_currentIndex === {$type}_maxIndex) {
		{$type}_nextButton.style.display = 0;
}

if ({$type}_currentIndex === 0) {
		{$type}_prevButton.style.opacity = 0;
}
{$type}_nextButton.addEventListener('click', () => {
	if ({$type}_currentIndex < {$type}_maxIndex) {
			const {$type}_t = -{$type}_currentIndex * {$type}_itemWidth;
			{$type}_currentIndex++;
			console.log({$type}_currentIndex, {$type}_itemWidth);
			{$type}_slider.style.transform = 'translateX(-' + ({$type}_currentIndex * {$type}_itemWidth) + 'px)';
			if ({$type}_currentIndex === {$type}_maxIndex) {
				{$type}_nextButton.style.opacity = 0;
			} else {
				{$type}_prevButton.style.opacity = 1;
			}
	}
});
{$type}_prevButton.addEventListener('click', () => {
	if ({$type}_currentIndex > 0) {
			const {$type}_t = -{$type}_currentIndex * {$type}_itemWidth;
			{$type}_currentIndex--;
			console.log({$type}_currentIndex, {$type}_itemWidth);
			{$type}_slider.style.transform = 'translateX(-' + ({$type}_currentIndex * {$type}_itemWidth) + 'px)';
			if ({$type}_currentIndex === 0) {
				{$type}_prevButton.style.opacity = 0;
			} else {
				{$type}_nextButton.style.opacity = 1;
			}
	}
});
</script>