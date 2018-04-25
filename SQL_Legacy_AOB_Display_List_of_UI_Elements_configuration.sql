  SELECT 
  eeg.ElementID,
  e.DisplayName,
  eeg.ElementGroupID,
  eg.ElementGroupDisplayName
   FROM dbo.ElementElementGroup eeg 
  INNER JOIN dbo.Element e ON e.ElementID = eeg.ElementID 
  INNER JOIN dbo.ElementGroup eg ON eg.ElementGroupID = eeg.ElementGroupID