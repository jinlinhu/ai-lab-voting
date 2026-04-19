-- Supabase 数据库表创建脚本
-- 用于AI拓边实验室讲演预约和打分系统

-- 1. 讲演预约表
CREATE TABLE IF NOT EXISTS presentation_bookings (
    id BIGSERIAL PRIMARY KEY,
    participant_name VARCHAR(50) NOT NULL,
    week_id INTEGER NOT NULL CHECK (week_id BETWEEN 1 AND 7),
    slot_number INTEGER NOT NULL CHECK (slot_number BETWEEN 1 AND 3),
    booked_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    
    -- 确保每人只能预约一次
    UNIQUE(participant_name),
    
    -- 确保每个时间段只能被一人预约
    UNIQUE(week_id, slot_number),
    
    -- 创建索引以提高查询性能
    INDEX idx_participant_name (participant_name),
    INDEX idx_week_id (week_id),
    INDEX idx_booked_at (booked_at DESC)
);

-- 2. 讲演打分表
CREATE TABLE IF NOT EXISTS presentation_scores (
    id BIGSERIAL PRIMARY KEY,
    rater_name VARCHAR(50) NOT NULL,
    presenter_name VARCHAR(50) NOT NULL,
    score INTEGER NOT NULL CHECK (score BETWEEN 1 AND 5),
    comment TEXT,
    scored_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    
    -- 确保每人只能给同一个讲演者打一次分
    UNIQUE(rater_name, presenter_name),
    
    -- 创建索引以提高查询性能
    INDEX idx_rater_name (rater_name),
    INDEX idx_presenter_name (presenter_name),
    INDEX idx_score (score),
    INDEX idx_scored_at (scored_at DESC)
);

-- 3. 启用行级安全 (Row Level Security)
ALTER TABLE presentation_bookings ENABLE ROW LEVEL SECURITY;
ALTER TABLE presentation_scores ENABLE ROW LEVEL SECURITY;

-- 4. 创建访问策略
-- 允许所有人读取预约数据
CREATE POLICY "允许所有人读取预约数据" ON presentation_bookings
    FOR SELECT USING (true);

-- 允许所有人插入预约数据（但通过唯一约束限制）
CREATE POLICY "允许所有人插入预约数据" ON presentation_bookings
    FOR INSERT WITH CHECK (true);

-- 允许用户删除自己的预约
CREATE POLICY "允许用户删除自己的预约" ON presentation_bookings
    FOR DELETE USING (participant_name = current_user);

-- 允许所有人读取评分数据
CREATE POLICY "允许所有人读取评分数据" ON presentation_scores
    FOR SELECT USING (true);

-- 允许所有人插入评分数据（但通过唯一约束限制）
CREATE POLICY "允许所有人插入评分数据" ON presentation_scores
    FOR INSERT WITH CHECK (true);

-- 5. 添加注释
COMMENT ON TABLE presentation_bookings IS '讲演预约记录表';
COMMENT ON TABLE presentation_scores IS '讲演评分记录表';

-- 6. 创建视图：讲演者平均分视图
CREATE OR REPLACE VIEW presenter_scores_summary AS
SELECT 
    presenter_name,
    COUNT(*) as rating_count,
    AVG(score) as average_score,
    MIN(score) as min_score,
    MAX(score) as max_score
FROM presentation_scores
GROUP BY presenter_name
ORDER BY average_score DESC;

-- 7. 创建视图：每周讲演安排视图
CREATE OR REPLACE VIEW weekly_schedule AS
SELECT 
    week_id,
    slot_number,
    participant_name,
    booked_at
FROM presentation_bookings
ORDER BY week_id, slot_number;

-- 8. 插入测试数据（可选）
-- INSERT INTO presentation_bookings (participant_name, week_id, slot_number) VALUES
-- ('胡金林', 1, 1),
-- ('陈华炎', 1, 2),
-- ('张文宇', 1, 3);

-- INSERT INTO presentation_scores (rater_name, presenter_name, score, comment) VALUES
-- ('陈华炎', '胡金林', 5, '讲得非常精彩'),
-- ('张文宇', '胡金林', 4, '内容充实'),
-- ('胡金林', '陈华炎', 5, '准备充分');