const { calculatePrice } = require('./VoNhatPhuong.BT3.2');

describe('calculatePrice', () => {
    test('should calculate the price correctly without discounts or delivery charges', () => {
        expect(calculatePrice(100, 4, false)).toBeCloseTo(100);
        expect(calculatePrice(50, 2, false)).toBeCloseTo(50);
        expect(calculatePrice(70, 3, false)).toBeCloseTo(70);
        expect(calculatePrice(99, 1, false)).toBeCloseTo(99);
        expect(calculatePrice(80, 0.5, false)).toBeCloseTo(80);
    });

    test('should apply 10% price reduction if price reaches 200 euros', () => {
        expect(calculatePrice(200, 1, false)).toBeCloseTo(180);
        expect(calculatePrice(250, 2, false)).toBeCloseTo(225);
        expect(calculatePrice(300, 3, false)).toBeCloseTo(270);
        expect(calculatePrice(400, 4, false)).toBeCloseTo(360);
        expect(calculatePrice(200, 5, false)).toBeCloseTo(180);
    });

    test('should apply delivery charges if weight exceeds 5 kg', () => {
        expect(calculatePrice(99, 9, false)).toBeCloseTo(108);
        expect(calculatePrice(50, 6, false)).toBeCloseTo(56);
        expect(calculatePrice(80, 7, false)).toBeCloseTo(87);
        expect(calculatePrice(70, 8, false)).toBeCloseTo(78);
        expect(calculatePrice(90, 10, false)).toBeCloseTo(100);
    });
    test('should apply free delivery charges if price exceeds 100 euros', () => {
        expect(calculatePrice(120, 6, false)).toBeCloseTo(120);
        expect(calculatePrice(150, 7, false)).toBeCloseTo(150);
        expect(calculatePrice(180, 8, false)).toBeCloseTo(180);
        expect(calculatePrice(200, 9, false)).toBeCloseTo(180); 
        expect(calculatePrice(300, 10, false)).toBeCloseTo(270); 
    });

    test('should apply 3% price reduction in reduced price if paid with credit card', () => {
        expect(calculatePrice(150, 4, true)).toBeCloseTo(145.5); 
        expect(calculatePrice(250, 6, true)).toBeCloseTo(218.25); 
        expect(calculatePrice(180, 6, true)).toBeCloseTo(174.6); 
        expect(calculatePrice(99, 2, true)).toBeCloseTo(96.03); 
        expect(calculatePrice(100, 5, true)).toBeCloseTo(102); 
    });
    

    test('should apply 15% price reduction if price reaches 200 euros, paid with credit card, and weight is under 5 kg', () => {
        expect(calculatePrice(200, 4, true)).toBeCloseTo(170); 
        expect(calculatePrice(250, 3, true)).toBeCloseTo(212.5); 
        expect(calculatePrice(300, 2, true)).toBeCloseTo(255); 
        expect(calculatePrice(400, 1, true)).toBeCloseTo(340); 
        expect(calculatePrice(200, 4.9, true)).toBeCloseTo(170);
    });

    // Other combinations: Add other combinations (if any) and its test cases
    test('should apply no discounts or free delivery if price < 100 and weight < 5kg', () => {
        expect(calculatePrice(50, 4, false)).toBeCloseTo(50);
        expect(calculatePrice(75, 3, true)).toBeCloseTo(72.75); 
        expect(calculatePrice(90, 4.5, false)).toBeCloseTo(90);
        expect(calculatePrice(99, 4.9, true)).toBeCloseTo(96.03); 
        expect(calculatePrice(100, 4.5, true)).toBeCloseTo(97); 
    });
});