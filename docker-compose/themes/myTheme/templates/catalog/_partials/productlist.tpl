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
<div id="next_button" class="next_button">
	<svg class="slider_svg" xmlns="http://www.w3.org/2000/svg" width="32" height="32" viewBox="0 0 20 20">
		<path fill="currentColor" fill-rule="evenodd" d="M7.21 14.77a.75.75 0 0 1 .02-1.06L11.168 10L7.23 6.29a.75.75 0 1 1 1.04-1.08l4.5 4.25a.75.75 0 0 1 0 1.08l-4.5 4.25a.75.75 0 0 1-1.06-.02Z" clip-rule="evenodd"></path>
	</svg>
</div> 
 <div id="prev_button" class="prev_button">
	<svg class="slider_svg" xmlns="http://www.w3.org/2000/svg" width="32" height="32" viewBox="0 0 20 20">
		<path fill="currentColor" fill-rule="evenodd" d="M12.79 5.23a.75.75 0 0 1-.02 1.06L8.832 10l3.938 3.71a.75.75 0 1 1-1.04 1.08l-4.5-4.25a.75.75 0 0 1 0-1.08l4.5-4.25a.75.75 0 0 1 1.06.02Z" clip-rule="evenodd"></path>
	</svg>
</div>
<div class="products{if !empty($cssClass)} {$cssClass}{/if}">
	<div  id="slider" class="products_wrapper">
    {include file="catalog/_partials/miniatures/custom_product.tpl" position=$position productClasses=$productClasses}
	</div>
</div>
 </div>

{if $type eq 'best'}
<span>THE BESTEST</span>
{/if}
<script>
const slider = document.getElementById('slider');
const nextButton = document.getElementById('next_button');
const prevButton = document.getElementById('prev_button');
let currentIndex = 0;

const totalItems = slider.children.length - 1;
const visibleItems = 4;
const itemWidth = slider.querySelector('.product').offsetWidth + 5;
const maxIndex = totalItems - visibleItems;
console.log(itemWidth, totalItems, visibleItems, maxIndex);
if (currentIndex === maxIndex) {
		nextButton.style.display = 0;
}

if (currentIndex === 0) {
		prevButton.style.opacity = 0;
}
nextButton.addEventListener('click', () => {
	if (currentIndex < maxIndex) {
			const t = -currentIndex * itemWidth;
			currentIndex++;
			console.log(currentIndex, itemWidth);
			slider.style.transform = 'translateX(-' + (currentIndex * itemWidth) + 'px)';
			if (currentIndex === maxIndex) {
				nextButton.style.opacity = 0;
			} else {
				prevButton.style.opacity = 1;
			}
	}
});
prevButton.addEventListener('click', () => {
	if (currentIndex > 0) {
			const t = -currentIndex * itemWidth;
			currentIndex--;
			console.log(currentIndex, itemWidth);
			slider.style.transform = 'translateX(-' + (currentIndex * itemWidth) + 'px)';
			if (currentIndex === 0) {
				prevButton.style.opacity = 0;
			} else {
				nextButton.style.opacity = 1;
			}
	}
});
</script>