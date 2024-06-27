function calculatePrice(price, weight, paidWithCreditCard) {
    let totalPrice = price;

    if (price >= 200) {
        if (paidWithCreditCard && weight < 5) {
    
            totalPrice *= 0.85;
        } else {
            totalPrice *= 0.9;
        }
    }

    if (paidWithCreditCard && !(price >= 200 && weight < 5)) {
        totalPrice *= 0.97;
    }

    let deliveryPrice = 0;
    if (price <= 100 && weight >= 5) {
        deliveryPrice = weight;
    }

    return totalPrice + deliveryPrice;
}

module.exports = { calculatePrice };
