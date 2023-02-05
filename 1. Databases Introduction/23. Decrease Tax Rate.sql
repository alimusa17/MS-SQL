--23 Decrease Tax Rate

UPDATE Payments
   SET TaxRate = TaxRate * 0.97
   SELECT TaxRate FROM Payments