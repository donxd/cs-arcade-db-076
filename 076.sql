/*Please add ; after each select statement*/
CREATE PROCEDURE freeSeats()
BEGIN
    SELECT 
    f.flight_id
    -- , pl.plane_id
    -- , pl.number_of_seats
    -- , pu.seat_no
    -- , pu.used
    -- , (pl.number_of_seats - pu.seat_no) free_seats
    , IF(pu.used IS NOT NULL, (pl.number_of_seats - pu.used), pl.number_of_seats)  free_seats
    FROM flights f INNER JOIN 
    planes pl ON pl.plane_id = f.plane_id LEFT JOIN 
    (
        SELECT 
          flight_id
        , COUNT(*) as used
        FROM purchases 
        GROUP BY flight_id
    ) pu ON pu.flight_id = f.flight_id
    -- ORDER BY free_seats ASC 
    ORDER BY f.flight_id ASC
    ;
END