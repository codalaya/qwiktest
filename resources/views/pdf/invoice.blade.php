<!DOCTYPE html>
<html lang="{{ str_replace('_', '-', app()->getLocale()) }}">
<head>
    <meta charset="utf-8" />
    <title>{{ $payment['invoice_no'] }}</title>

    <style>
        .invoice-box {
            max-width: 800px;
            position: relative;
            margin: auto;
            padding: 30px;
            font-size: 16px;
            line-height: 24px;
            font-family: 'Helvetica Neue', 'Helvetica', Helvetica, Arial, sans-serif;
            color: #555;
            z-index: 0;
        }

        .watermark{
            position:absolute;
            z-index: 1;
            display:block;
            min-height:100%;
            min-width:100%;
        }
        .watermark-text
        {
            color:lightgrey;
            font-size: 100px;
            font-family: 'Helvetica Neue', 'Helvetica', Helvetica, Arial, sans-serif;
            transform:rotate(300deg);
            -webkit-transform:rotate(300deg);
            text-transform: uppercase;
        }

        .invoice-box table {
            width: 100%;
            line-height: inherit;
            text-align: left;
        }

        .invoice-box table td {
            padding: 5px;
            vertical-align: top;
        }

        .invoice-box table tr td:nth-child(2) {
            text-align: right;
        }

        .invoice-box table tr.top table td {
            padding-bottom: 20px;
        }

        .invoice-box table tr.top table td.title {
            font-size: 45px;
            line-height: 45px;
            color: #333;
        }

        .invoice-box table tr.information table td {
            padding-bottom: 40px;
        }

        .invoice-box table tr.heading td {
            background: #eee;
            border-bottom: 1px solid #ddd;
            font-weight: bold;
        }

        .invoice-box table tr.details td {
            padding-bottom: 20px;
        }

        .invoice-box table tr.item td {
            border-bottom: 1px solid #eee;
        }

        .invoice-box table tr.item.last td {
            border-bottom: none;
        }

        .invoice-box table tr.total td:nth-child(2) {
            border-top: 2px solid #eee;
            font-weight: bold;
        }

        @media only screen and (max-width: 600px) {
            .invoice-box table tr.top table td {
                width: 100%;
                display: block;
                text-align: center;
            }

            .invoice-box table tr.information table td {
                width: 100%;
                display: block;
                text-align: center;
            }
        }

        /** RTL **/
        .invoice-box.rtl {
            direction: rtl;
            font-family: Tahoma, 'Helvetica Neue', 'Helvetica', Helvetica, Arial, sans-serif;
        }

        .invoice-box.rtl table {
            text-align: right;
        }

        .invoice-box.rtl table tr td:nth-child(2) {
            text-align: left;
        }
        .print-button {
            float: right;
            margin-bottom: 10px;
        }
        @media print {
            .d-print-none {
                display: none !important;
            }
        }
    </style>
</head>

<body onload="window.print();">
<button class="d-print-none print-button" onclick="window.print();">{{ __('Print Invoice') }}</button>
<div class="invoice-box">
    @if($payment['status'] !== 'success')
        <div class="watermark">
            <p class="watermark-text">{{ $payment['status'] }}</p>
        </div>
    @endif
    <table cellpadding="0" cellspacing="0">
        <tr class="top">
            <td colspan="2">
                <table>
                    <tr>
                        <td class="title">
                            <img src="{{ $logo }}" style="width: 100%; max-width: 200px" alt="" />
                        </td>

                        <td>
                            {{ __('Invoice') }} #: {{ $payment['invoice_no'] }}<br />
                            {{ __('Date') }}: {{ $payment['date'] }}<br /><br /><br />
                        </td>
                    </tr>
                </table>
            </td>
        </tr>

        <tr class="information">
            <td colspan="2">
                <table>
                    <tr>
                        <td>
                            @if($data['vendor_billing_information']['vendor_name'] != '-')
                                {{  $data['vendor_billing_information']['vendor_name'] }}<br />
                            @endif
                                @if($data['vendor_billing_information']['address'] != '-')
                                    {{  $data['vendor_billing_information']['address'] }}<br />
                                @endif
                                @if($data['vendor_billing_information']['city'] != '-')
                                    {{  $data['vendor_billing_information']['city'] }},
                                    @if($data['vendor_billing_information']['state'] != '-')
                                        {{  $data['vendor_billing_information']['state'] }},
                                        @if($data['vendor_billing_information']['country'] != '-')
                                            {{  $data['vendor_billing_information']['country'] }}<br />
                                        @endif
                                    @endif
                                @endif
                                @if($data['vendor_billing_information']['zip'] != '-')
                                    {{  $data['vendor_billing_information']['zip'] }}<br />
                                @endif
                                @if($data['vendor_billing_information']['phone_number'] != '-')
                                    {{ __('Phone') }}: {{  $data['vendor_billing_information']['phone_number'] }}<br />
                                @endif
                                @if($data['vendor_billing_information']['vat_number'] != '-')
                                    {{ __('VAT') }}: {{  $data['vendor_billing_information']['vat_number'] }}
                                @endif
                        </td>

                        <td>
                            <strong>{{ __('Billed To') }}</strong><br />
                            @if($data['customer_billing_information']['full_name'])
                                {{  $data['customer_billing_information']['full_name'] }}<br />
                            @endif
                            @if($data['customer_billing_information']['address'])
                                {{  $data['customer_billing_information']['address'] }}<br />
                            @endif
                            @if($data['customer_billing_information']['city'])
                                {{  $data['customer_billing_information']['city'] }},
                                @if($data['customer_billing_information']['state'])
                                    {{  $data['customer_billing_information']['state'] }},
                                    @if($data['customer_billing_information']['country'])
                                        {{  $data['customer_billing_information']['country'] }}<br />
                                    @endif
                                @endif
                            @endif
                            @if($data['customer_billing_information']['zip'] != '-')
                                {{  $data['customer_billing_information']['zip'] }}<br />
                            @endif
                            @if($data['customer_billing_information']['email'])
                                {{  $data['customer_billing_information']['email'] }}
                            @endif
                        </td>
                    </tr>
                </table>
            </td>
        </tr>

        <tr class="heading">
            <td>{{ __('Payment Method') }}</td>

            <td>{{ __('Payment ID') }}</td>
        </tr>

        <tr class="details">
            <td>{{ $payment['method'] }}</td>

            <td>{{ $payment['payment_id'] }}</td>
        </tr>

        <tr class="heading">
            <td>{{ __('Item') }}</td>

            <td>{{ __('Price') }}</td>
        </tr>

        @foreach($data['order_summary']['items'] as $item)
            <tr class="item">
                <td>{{ $item['name'] }}</td>

                <td>{{ $item['amount_formatted'] }}</td>
            </tr>
        @endforeach
        @foreach($data['order_summary']['taxes'] as $tax)
            <tr class="item">
                <td>{{ $tax['name'] }} ({{ ucfirst($tax['type']) }})</td>

                <td>{{ $tax['amount_formatted'] }}</td>
            </tr>
        @endforeach

        <tr class="total">
            <td></td>

            <td>{{ __('Total') }}: {{ $data['order_summary']['total_formatted'] }}</td>
        </tr>
    </table>
</div>
</body>
</html>
