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
 <style>
 .footer-container-before {
  width: 100%;
  padding: 0;
  margin: 0;
  display: flex;
  justify-content: center;
    background-color: rgba(0,185,205,.1)
 }
 .footer-container-before > .row {
	width: 1170px;
	display: flex;
	justify-content: center;
 }
 .four-col-container {
  display: flex;
}
.four-col {
  flex: 1;
  height: 376px;
  display: flex;
}
 </style>
 	<img style="width:100%" class="whole_width" src="http://localhost:8080\themes\myTheme\images\trustpilot.png">
<div class="container footer-container-before">
  <div class="row">
    {block name='hook_footer_before'}
      {hook h='displayFooterBefore'}
    {/block}
  </div>
</div>

<div class="four-col-container">
  <div class="four-col">
    <p>
    Hobbii.pl to kompleksowy sklep dla miłośników włóczek z całego świata! Mamy wszystko, czego potrzebujesz do swojego kolejnego projektu na drutach lub szydełku. Znajdujemy się w pięknej Kopenhadze w Danii, gdzie wszystkie produkty są projektowane, a wszystkie zamówienia są pakowane i wysyłane.
    </p>
  </div>
  <div class="four-col">
    <div class="four2-col">
      <p>
        Dortheavej 8-12A
        DK - 2400 København
        Org. nr: 36909587
      </p>
    </div>
    <div class="four2-col">
      <h2>Hobbii</h2>
      <ul>
        <li>Zarejestruj się za darmo</li>
        <li>Blod</li>
        <li>Nowe produkty</li>
        <li>Nowe wzory</li>
        <li>Karta podarukowa</li>
        <li>O Hobbii </li>
      </ul>
    </div>
  </div>
</div>
<div class="footer-container">
  <div class="container">
    <div class="row">
      {block name='hook_footer'}
        {hook h='displayFooter'}
      {/block}
    </div>
    <div class="row">
      {block name='hook_footer_after'}
        {hook h='displayFooterAfter'}
      {/block}
    </div>
    <div class="row">
      <div class="col-md-12">
        <p class="text-sm-center">
          {block name='copyright_link'}
            <a href="https://www.prestashop.com" target="_blank" rel="noopener noreferrer nofollow">
              {l s='%copyright% %year% - Ecommerce software by %prestashop%' sprintf=['%prestashop%' => 'PrestaShop™', '%year%' => 'Y'|date, '%copyright%' => '©'] d='Shop.Theme.Global'}
            </a>
          {/block}
        </p>
      </div>
    </div>
  </div>
</div>
