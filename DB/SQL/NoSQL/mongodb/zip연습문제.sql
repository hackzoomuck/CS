//1. SQL: SELECT COUNT(*) AS count FROM zip
db.us_col.aggregate([
    {$group:{_id:"", count:{"$sum":1}}}
])
//2. SQL: SELECT SUM(pop) as total_pop AS count FROM zip
db.us_col.aggregate(
    {$group:{_id:"pop",total_pop:{"$sum":"$pop"}}}
)
//3. SQL: SELECT state, SUM(pop) as total_pop FROM zip GROUP BY state
db.us_col.aggregate(
    {
        $group:{
        _id:'$state',
        total_pop:{$sum:'$pop'}
        }
    }
)
//4. SQL : select city, sum(pop) as total_pop from zip group by city
db.us_col.aggregate(
    {
        $group:{
           _id:'$city',
           total_pop:{$sum:'$pop'}
        }
    }
)
//5. SQL: SELECT state, SUM(pop) as total_pop FROM zip GROUP BY state ORDER BY as total_pop
db.us_col.aggregate(
    {
        $group:{
            _id:'$state',
            total_pop:{$sum:'$pop'}
        }
    },
    {
        $sort:{
            total_pop:1
        }
    }
)
//6. # SQL: SELECT COUNT(*) FROM zip WHERE state = 'MA'
db.us_col.aggregate(
    {
        $match:{ state: 'MA'}
    },
    {
        $group:{
            _id: "$state",
            total:{$sum:1}
        }
    }
)
//7. select state,sum(pop) as total_pop from zip where state = 'MA' group by state
db.us_col.aggregate(
    {
        $match:{state:'MA'}
    },
    {
        $group:{
            _id: "$state",
            total_pop:{$sum:"$pop"}
        }
    }
)
//7.1 select state,sum(pop) as total_pop from zip where state in ('DE', 'MS') group by state
db.us_col.aggregate(
    {
        $match:{state:{$in:['DE','MS']}},
    },
    {
        $group:{_id:"$state",total_pop:{$sum:"$pop"}}
    }
)
//8. SELECT state, SUM(pop) as total_pop FROM zip GROUP BY state HAVING SUM(pop) > 10000000
db.us_col.aggregate(
    {
        $group:{
            _id:"$state",
            total_pop:{$sum:"$pop"}
        }
    },
    {
        $match:{
            total_pop:{$gt:10000000}
        }
    }
)
//9.1000만 이상의 state 별 총 인구를 state_pop 필드명으로 출력하고 _id는 출력하지 않기
db.us_col.aggregate([
    {
        $group: {
            _id:"$state",
            state_pop:{$sum:"$pop"}
        }
    },
    {
        $match:{
            state_pop:{$gte:10000000}
        }
    },
    {
        $project:{
            _id:0
        }
    }
])

//10.1000만 이상의 state만 내림차순 정렬하여 3개만 가져오기
db.us_col.aggregate([
    {
        $group: {
            _id:"$state",
            state_pop:{$sum:"$pop"}
        }
    },
    {
        $match:{
            state_pop:{$gte:1000000}
        }
    },
    {
        $sort:{state_pop:-1}
    },
    {
        $limit:3
    }
])
//11.1000만 이상의 state 별 총 인구를 state_pop 필드명으로 출력하고,
// _id는 출력하지 않으며, 가장 많은 인구를 가진 3개만 출력하기
db.us_col.aggregate([
    {
        $group: {
            _id:"$state",
            state_pop:{$sum:"$pop"}
        }
    },
    {
        $match:{
            state_pop:{$gte:1000000}
        }
    },
    {
        $sort:{state_pop:-1}
    },
    {
        $limit:3,
    },
    {
        $project:{
            _id:0
        }
    }
])

//12. select state, city, sum(pop) as total_pop from zip group by state,city
db.us_col.aggregate(
    {
        $group:{
            _id:{
                state:"$state",
                city:"$city"
            },
            total_pop:{$sum:"$pop"}
        }
    }
)
//13. select state, city, sum(pop) as total_pop from zip GROUP BY state, city HAVING city = 'POINT BAKER'
db.us_col.aggregate(
    {
        $group:{
            _id:{
                state:"$state",
                city:"$city"
            },
            total_pop:{$sum:"$pop"}
        }
    },
     {
        $match:{
            '_id.city':'POINT BAKER'
        }
    }
)
//14. SELECT AVG(pop) FROM zip GROUP BY state, city
db.us_col.aggregate(
    {
        $group:{
            _id:{
                state:"$state",
                city:"$city"
            },
            avg: {$avg:"$pop"}
        }
    }

)
//15. select state,city, avg(pop) as avg_pop from zip  GROUP BY state, city  having avg_pop > 30000
//주별 도시 인구 평균이 30000 이 넘는 곳의 state 와 city 이름만 출력하고 평균을 출력하지 않기 (3개만 출력하기)
db.us_col.aggregate(
    {
        $group:{
            _id:{
                state:"$state",
                city:"$city"
            },
            avg_pop: {$avg:"$pop"}
        }
    },
    {
        $match:{
            avg_pop:{$gt:30000}
        }
    },
    {
        $project:{
            avg_pop:0
        }
    },
    {
        $limit:3
    }
)
