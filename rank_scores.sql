SELECT Score, DENSE_RANK() OVER (ORDER BY Score DESC) AS Rank
FROM Scores
ORDER BY Score DESC;

/*
RANK: if same value, give same rank, skip rank number for the next one
DENSE_RANK: will not skip rank number for the next one(no gap between rank number)
ROW_NUMBER: if same value, rank according to row number
*/