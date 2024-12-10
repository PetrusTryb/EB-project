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
	width: 1170px;
	margin: 0 auto;
  display: flex;
}
.four-col {
  flex: 1;
  height: 376px;
  display: flex;
	padding: 16px;
}
.four2-col {
	padding: 16px;
	flex: 1;
}
.four-col > p {
	font-size: 20px;
	line-height: 1.5rem;
}
/*.socials > * {
	width: 48px;
	height: 48px;
	border: 1px solid gray;
	border-radius: 50%;
}
.socials {
	display: flex;
	gap: 10px;
}*/
.chat_button {
	width: 60px;
	height: 60px;
	border-radius: 50%;
	position: fixed;
    bottom: calc(70px);
    right: calc(20px);
	background: #00B9CD;
	display: flex;
	justify-content: center;
	align-items: center;
	box-shadow: 0px 4px 8px 0px rgba(0, 0, 0, 0.04), 0px 0px 1px 0px rgba(0, 0, 0, 0.16), 0px 8px 48px 0px rgba(0, 0, 0, 0.06);
}
.items-center {
	font-size: 14px;
}
.grow {
	margin: 0 auto;
	padding: 0 50px;
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
  <div class="four-col" style="display: flex; flex-direction: column;">
    <p>
    Hobbii.pl to kompleksowy sklep dla miłośników włóczek z całego świata! Mamy wszystko, czego potrzebujesz do swojego kolejnego projektu na drutach lub szydełku. Znajdujemy się w pięknej Kopenhadze w Danii, gdzie wszystkie produkty są projektowane, a wszystkie zamówienia są pakowane i wysyłane.
    </p>
			{include file="_partials/google_play.tpl"}
		<div>
			<h3> Śledź nas </h3>
			<div class="socials">
				<!--<svg xmlns="http://www.w3.org/2000/svg" x="0px" y="0px" width="100" height="100" viewBox="0 0 48 48">
<path fill="#039be5" d="M24 5A19 19 0 1 0 24 43A19 19 0 1 0 24 5Z"></path><path fill="#fff" d="M26.572,29.036h4.917l0.772-4.995h-5.69v-2.73c0-2.075,0.678-3.915,2.619-3.915h3.119v-4.359c-0.548-0.074-1.707-0.236-3.897-0.236c-4.573,0-7.254,2.415-7.254,7.917v3.323h-4.701v4.995h4.701v13.729C22.089,42.905,23.032,43,24,43c0.875,0,1.729-0.08,2.572-0.194V29.036z"></path>
</svg>
<svg xmlns="http://www.w3.org/2000/svg" x="0px" y="0px" width="100" height="100" viewBox="0 0 48 48">
<circle cx="24" cy="24" r="20" fill="#E60023"></circle><path fill="#FFF" d="M24.4439087,11.4161377c-8.6323242,0-13.2153931,5.7946167-13.2153931,12.1030884	c0,2.9338379,1.5615234,6.5853882,4.0599976,7.7484131c0.378418,0.1762085,0.581543,0.1000366,0.668457-0.2669067	c0.0668945-0.2784424,0.4038086-1.6369019,0.5553589-2.2684326c0.0484619-0.2015381,0.0246582-0.3746338-0.1384277-0.5731201	c-0.8269653-1.0030518-1.4884644-2.8461304-1.4884644-4.5645752c0-4.4115601,3.3399658-8.6799927,9.0299683-8.6799927	c4.9130859,0,8.3530884,3.3484497,8.3530884,8.1369019c0,5.4099731-2.7322998,9.1584473-6.2869263,9.1584473	c-1.9630737,0-3.4330444-1.6238403-2.9615479-3.6153564c0.5654297-2.3769531,1.6569214-4.9415283,1.6569214-6.6584473	c0-1.5354004-0.8230591-2.8169556-2.5299683-2.8169556c-2.006958,0-3.6184692,2.0753784-3.6184692,4.8569336	c0,1.7700195,0.5984497,2.9684448,0.5984497,2.9684448s-1.9822998,8.3815308-2.3453979,9.9415283	c-0.4019775,1.72229-0.2453003,4.1416016-0.0713501,5.7233887l0,0c0.4511108,0.1768799,0.9024048,0.3537598,1.3687744,0.4981079l0,0	c0.8168945-1.3278198,2.0349731-3.5056763,2.4864502-5.2422485c0.2438354-0.9361572,1.2468872-4.7546387,1.2468872-4.7546387	c0.6515503,1.2438965,2.5561523,2.296936,4.5831299,2.296936c6.0314941,0,10.378418-5.546936,10.378418-12.4400024	C36.7738647,16.3591919,31.3823242,11.4161377,24.4439087,11.4161377z"></path>
</svg>
<svg xmlns="http://www.w3.org/2000/svg" x="0px" y="0px" width="100" height="100" viewBox="0 0 48 48">
<path fill="#FF3D00" d="M43.2,33.9c-0.4,2.1-2.1,3.7-4.2,4c-3.3,0.5-8.8,1.1-15,1.1c-6.1,0-11.6-0.6-15-1.1c-2.1-0.3-3.8-1.9-4.2-4C4.4,31.6,4,28.2,4,24c0-4.2,0.4-7.6,0.8-9.9c0.4-2.1,2.1-3.7,4.2-4C12.3,9.6,17.8,9,24,9c6.2,0,11.6,0.6,15,1.1c2.1,0.3,3.8,1.9,4.2,4c0.4,2.3,0.9,5.7,0.9,9.9C44,28.2,43.6,31.6,43.2,33.9z"></path><path fill="#FFF" d="M20 31L20 17 32 24z"></path>
</svg>
<img src="http://localhost:8080\themes\myTheme\images\icons8-ravelry-24.png">-->
					{include file="_partials/socials.tpl"}
			</div>
		</div>
  </div>
  <div class="four-col">
    <div class="four2-col">
		<ul>
			<li>		Dortheavej 8-12A      </li>
			<li>		DK - 2400 København      </li>
			<li>		Org. nr: 36909587      </li>
		</ul>

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
<div style="display: flex; width: 1170px; height: 150px; padding: 24px 16px;margin: 0 auto;">
	<div style="flex: 1">
		<h2>100% bezpieczna płatność. Zawsze.</h2>
		<span>Jeśli masz jakiekolwiek pytania dotyczące metod płatności, nie wahaj się z nami skontaktować.
		</span>
		<div>
					{include file="_partials/svgs.tpl"}
		</div>
	</div>
	<div style="flex: 1">
		<h2> Szybka dostawa </h2>
		<div>
<svg class="h-8 md:h-11 w-auto" width="71" height="45" viewBox="0 0 71 45" fill="none" xmlns="http://www.w3.org/2000/svg">
  <g clip-path="url(#clip0_2117_17273)">
  	<path d="M66.5 0.5H4.5C2.29086 0.5 0.5 2.29086 0.5 4.5V40.5C0.5 42.7091 2.29086 44.5 4.5 44.5H66.5C68.7091 44.5 70.5 42.7091 70.5 40.5V4.5C70.5 2.29086 68.7091 0.5 66.5 0.5Z" fill="#FFCC00" stroke="#D8D8D8"></path>
  	<path d="M1 26.9373H9.36072L8.88022 27.61H1V26.9373Z" fill="#D40511"></path>
  	<path d="M69.952 27.61H59.7173L60.2458 26.9373H70V27.61H69.952Z" fill="#D40511"></path>
  	<path d="M1 25.688H10.3217L9.79317 26.3608H1V25.688Z" fill="#D40511"></path>
  	<path d="M1 24.4387H11.2827L10.7542 25.1114H1V24.4387Z" fill="#D40511"></path>
  	<path d="M69.9519 26.3608H60.6782L61.2068 25.688H70V26.3608H69.9519Z" fill="#D40511"></path>
  	<path d="M62.1197 24.4387H69.9519V25.1114H61.5912L62.1197 24.4387Z" fill="#D40511"></path>
  	<path d="M10.0334 27.61L14.4541 21.6998C14.4541 21.6998 19.3552 21.6998 19.9318 21.6998C20.5564 21.6998 20.5564 21.9401 20.2201 22.3245C19.9318 22.7089 19.4032 23.4296 19.1149 23.814C18.9708 24.0543 18.6825 24.3906 19.5954 24.3906C20.6045 24.3906 26.9471 24.3906 26.9471 24.3906C26.3705 25.2555 24.3524 27.658 20.7967 27.658C17.9137 27.61 10.0334 27.61 10.0334 27.61Z" fill="#D40511"></path>
  	<path d="M35.3559 24.4387L32.9534 27.6581H26.6588L29.0613 24.4387H35.3559Z" fill="#D40511"></path>
  	<path d="M44.5335 24.4387L42.1309 27.6581H35.7883L38.1908 24.4387H44.5335Z" fill="#D40511"></path>
  	<path d="M46.5995 24.4387C46.5995 24.4387 46.119 25.0634 45.9268 25.3517C45.11 26.4088 45.8307 27.6581 48.4254 27.6581C51.4046 27.6581 58.6121 27.6581 58.6121 27.6581L61.0146 24.4387H46.5995Z" fill="#D40511"></path>
  	<path d="M13.1567 18.0481L10.9464 20.9791C10.9464 20.9791 22.3343 20.9791 22.9589 20.9791C23.5836 20.9791 23.5836 21.2194 23.2472 21.6038C22.9589 21.9882 22.4304 22.7089 22.1421 23.0933C21.9979 23.2855 21.7096 23.6699 22.6226 23.6699C23.6316 23.6699 27.5237 23.6699 27.5237 23.6699C27.5237 23.6699 28.3406 22.6128 28.9652 21.6999C29.8782 20.4986 29.0613 18 25.842 18C22.9589 18.0481 13.1567 18.0481 13.1567 18.0481Z" fill="#D40511"></path>
  	<path d="M45.062 23.6699H29.5898L33.8183 18.048H40.1609L37.7584 21.2674H40.5933L42.9958 18.048H49.3384L45.062 23.6699Z" fill="#D40511"></path>
  	<path d="M58.0836 18.048L53.8552 23.6699H47.1282L51.3566 18.048H58.0836Z" fill="#D40511"></path>
  </g>
  <defs>
  	<clipPath id="clip0_2117_17273">
  		<rect width="71" height="45" fill="white"></rect>
  	</clipPath>
  </defs>
</svg>
		</div>
	</div>
</div>
<!--<div class="footer-container">
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
</div>-->
<div style="height: 116px; padding: 24px; width: 100%; background: #00b9cd" class="new_footer_container">
 <div class="chat_button">
 <svg style="width: 44px; height: 44px;" width="24" height="24" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg" data-testid="chat-bubble-logo" class="ButtonAvatarstyles__KindlyIcon-sc-15ijr09-1 fNHNnJ"><g clip-path="url(#clip0_519_2415)"><path d="M19.1139 19.1612C18.2263 19.2692 17.4673 19.4161 16.704 19.4427C15.4118 19.4878 14.1095 19.5471 12.8248 19.4387C10.2337 19.2202 7.90467 18.3755 6.23998 16.1792C3.04902 11.9685 5.4046 5.64697 10.5428 4.64327C14.6026 3.85025 18.3702 6.42302 19.0886 10.5352C19.4999 12.8902 18.8789 14.9851 17.3057 16.7773C17.2046 16.8925 17.1038 17.0077 16.9725 17.1577C17.8893 18.0155 18.6031 18.6834 19.1139 19.1612Z" stroke="#ffffff" stroke-width="1.5"></path></g><defs><clipPath id="clip0_519_2415"><rect width="24" height="24" fill="#ffffff"></rect></clipPath></defs></svg>
 </div>
 <div style="display: flex;     justify-content: space-around;"class="grow py-2.5">
  <div class="mb-2 flex flex-wrap gap-2 "><a class="text-white hover:text-primary-200" href="/policies/terms-of-service">Zasady i Warunki</a>
		<span class="inline-flex items-center px-2 lg:px-4">
      <span class="inline-block h-1 w-1 rounded-full bg-white"></span>
    </span>
		<a class="text-white hover:text-primary-200" href="/policies/privacy-policy">Polityka Cookie</a>
<span class="inline-flex items-center px-2 lg:px-4">
                <span class="inline-block h-1 w-1 rounded-full bg-white"></span>
              </span><a class="text-white hover:text-primary-200" href="/pages/membership-conditions">Warunki Członkostwa</a>
<span class="wv-hidden inline-flex items-center px-2">
            <span class="inline-block h-1 w-1 rounded-full bg-white"></span>
          </span><!-- Toggle UserCentrics Consent Management see code in /snippets/header-tracking-scripts.liquid -->
        <span class="js-footer-manage-consent-link cursor-pointer text-white hover:text-primary-200">
          Zarządzaj plikami cookie
        </span>
      </div>
			<div>
			<img src="https://hobbii.pl/cdn/shop/t/4/assets/hobbii-flag-PL-f53e6cae.svg" class="h-auto w-5" width="20" height="20" loading="lazy" alt="pl">
			<span style="text-decoration: underline; color: white"> Polska (PLN) </span>
			<svg style="color: white" xmlns="http://www.w3.org/2000/svg" width="1em" height="1em" viewBox="0 0 20 20" class="-ml-1 text-xl"><path fill="currentColor" fillRule="evenodd" d="M5.23 7.21a.75.75 0 0 1 1.06.02L10 11.168l3.71-3.938a.75.75 0 1 1 1.08 1.04l-4.25 4.5a.75.75 0 0 1-1.08 0l-4.25-4.5a.75.75 0 0 1 .02-1.06Z" clipRule="evenodd"></path></svg>
			</div>
    </div>
      <div style="margin-left: 250px" class="text-primary-200">
        Chroniony prawem autorskim Hobbii A/S
      </div>
</div>