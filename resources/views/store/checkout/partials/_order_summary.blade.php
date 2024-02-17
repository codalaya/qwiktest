<h2 class="text-lg border-b border-gray-200 pb-2 font-semibold text-primary">{{ __('Order Summary') }}</h2>
<div class="mt-4">
    <dl class="space-y-4">
        @foreach($order['items'] as $item)
            <div class="flex items-start justify-between">
                <dt class="">
                    <div>{{ $item['name'] }}</div>
                    @if($item['discount'])
                        <div class="text-secondary">{{ $item['discount'] }} {{ __('Discount Applied') }}</div>
                    @endif
                </dt>
                <dd class=" font-medium text-gray-900">
                    @if($item['discount'])
                        <span class="line-through mr-1">{{ $item['original_price'] }}</span>
                    @endif
                    <span>{{ $item['amount_formatted'] }}</span>
                </dd>
            </div>
        @endforeach
        @foreach($order['taxes'] as $tax)
            <div class="flex items-center justify-between">
                <dt class="">
                    {{ $tax['name'] }} ({{ ucfirst($tax['type']) }})
                </dt>
                <dd class=" font-medium text-gray-900">
                    {{ $tax['amount_formatted'] }}
                </dd>
            </div>
        @endforeach
        <div class="flex items-center justify-between border-t border-dotted border-gray-200 pt-4">
            <dt class="text-base font-semibold">
                {{ __('Total') }}
            </dt>
            <dd class="text-base font-semibold text-gray-900">
                {{ $order['total_formatted'] }}
            </dd>
        </div>
    </dl>
</div>
