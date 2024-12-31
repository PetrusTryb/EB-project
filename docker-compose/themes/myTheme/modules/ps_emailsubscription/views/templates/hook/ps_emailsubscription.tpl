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
.block_newsletter {
  display: flex;
  flex-direction: row;
  margin: unset;
	padding: 0;
}
.second_column {
	background: rgba(0,185,205,.1);
}

.input-wrapper > input {
	margin-bottom: 10px;
	width: 100%;
	border-radius: 10px;
}

</style>
<div class="block_newsletter col-lg-8 col-md-12 col-sm-12" id="blockEmailSubscription_{$hookName}">
<img src="\themes\myTheme\images\emma_1-2.webp">
    <div class="col-md-7 col-xs-12 second_column">
      <form action="{$urls.current_url}#blockEmailSubscription_{$hookName}" method="post">
        <div class="row">
          <div class="col-xs-12">
          <h1 style="text-align: center">♥️ NEWSLETTER ♥️</h1>
          <p style="text-align: center">
            Zapisz się do naszego bezpłatnego newslettera i weź udział w konkursie, w którym możesz wygrać kartę podarunkową o wartości 250 zł. Możesz zrezygnować z subskrypcji w dowolnym momencie.
          </p>
            <input
              class="btn btn-primary float-xs-right hidden-sm-up"
              name="submitNewsletter"
              type="submit"
              value="{l s='OK' d='Shop.Theme.Actions'}"
            >
            <div class="input-wrapper">
							<input
                name="email"
                type="email"
                value="{$value}"
                placeholder="Imię"
                aria-labelledby="block-newsletter-label"
                required
              >
              <input
                name="email"
                type="email"
                value="{$value}"
                placeholder="Adres e-mail"
                aria-labelledby="block-newsletter-label"
                required
              >
							<input
              class="btn btn-primary float-xs-right hidden-xs-down"
              name="submitNewsletter"
              type="submit"
              value="Zapisz się"
            >
            </div>
            <input type="hidden" name="blockHookName" value="{$hookName}" />
            <input type="hidden" name="action" value="0">
            <div class="clearfix"></div>
          </div>
          <div class="col-xs-12">
              {if $conditions}
                <p>{$conditions}</p>
              {/if}
              {if $msg}
                <p class="alert {if $nw_error}alert-danger{else}alert-success{/if}">
                  {$msg}
                </p>
              {/if}
              {hook h='displayNewsletterRegistration'}
              {if isset($id_module)}
                {hook h='displayGDPRConsent' id_module=$id_module}
              {/if}
          </div>
        </div>
      </form>
    </div>
</div>

